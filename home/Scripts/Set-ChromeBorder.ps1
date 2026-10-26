param(
    [ValidateSet('List', 'Test', 'Apply', 'Reset', 'Watch')][string]$Mode = 'List',
    [ValidateSet('Black', 'None')][string]$Color = 'Black',
    [int]$IntervalSeconds = 3
)

# Sets the DWM border color (DWMWA_BORDER_COLOR, Windows 11 build 22000+) on open Chrome windows.
# Nothing is persisted by Windows: closing a window or restarting Chrome restores the default border.
# -Mode Watch keeps running and re-applies the color to any new Chrome window.
Add-Type @'
using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using System.Text;

public static class DwmBorder {
    delegate bool EnumProc(IntPtr hWnd, IntPtr lParam);
    [DllImport("user32.dll")] static extern bool EnumWindows(EnumProc cb, IntPtr lParam);
    [DllImport("user32.dll")] static extern bool IsWindowVisible(IntPtr hWnd);
    [DllImport("user32.dll", CharSet = CharSet.Unicode)] static extern int GetWindowText(IntPtr hWnd, StringBuilder s, int max);
    [DllImport("user32.dll", CharSet = CharSet.Unicode)] static extern int GetClassName(IntPtr hWnd, StringBuilder s, int max);
    [DllImport("user32.dll")] static extern uint GetWindowThreadProcessId(IntPtr hWnd, out uint pid);
    [DllImport("user32.dll")] static extern IntPtr GetWindow(IntPtr hWnd, uint cmd);
    [DllImport("user32.dll")] static extern bool GetWindowRect(IntPtr hWnd, out RECT r);
    [DllImport("dwmapi.dll")] static extern int DwmSetWindowAttribute(IntPtr hWnd, int attr, ref uint val, int size);

    [StructLayout(LayoutKind.Sequential)] struct RECT { public int L, T, R, B; }

    public static List<IntPtr> Find(HashSet<uint> chromePids) {
        var found = new List<IntPtr>();
        EnumWindows((h, l) => {
            if (!IsWindowVisible(h) || GetWindow(h, 4) != IntPtr.Zero) return true; // GW_OWNER
            uint pid; GetWindowThreadProcessId(h, out pid);
            if (!chromePids.Contains(pid)) return true;
            var cls = new StringBuilder(256); GetClassName(h, cls, 256);
            if (cls.ToString() != "Chrome_WidgetWin_1") return true;
            var title = new StringBuilder(512); GetWindowText(h, title, 512);
            if (title.Length == 0) return true;
            RECT r; GetWindowRect(h, out r);
            if (r.R - r.L < 200 || r.B - r.T < 200) return true;
            found.Add(h);
            return true;
        }, IntPtr.Zero);
        return found;
    }

    public static string Title(IntPtr h) { var t = new StringBuilder(512); GetWindowText(h, t, 512); return t.ToString(); }

    // COLORREF is 0x00BBGGRR. 0xFFFFFFFF = default, 0xFFFFFFFE = no border.
    public static int SetBorder(IntPtr h, uint colorref) { return DwmSetWindowAttribute(h, 34, ref colorref, 4); }

    // DWMWA_WINDOW_CORNER_PREFERENCE (33): 0 = default, 1 = do not round, 2 = round, 3 = round small.
    public static int SetCorners(IntPtr h, uint pref) { return DwmSetWindowAttribute(h, 33, ref pref, 4); }
}
'@

function Get-ChromeWindows {
    $pids = [System.Collections.Generic.HashSet[uint32]]::new()
    Get-Process chrome -ErrorAction SilentlyContinue | ForEach-Object { [void]$pids.Add([uint32]$_.Id) }
    return [DwmBorder]::Find($pids)
}

[uint32]$value = switch ($Mode) {
    # Decimal on purpose: PowerShell parses 0xFFFFFFFF-style hex literals as signed Int32.
    'Reset' { [uint32]4294967295 }
    default { if ($Color -eq 'None') { [uint32]4294967294 } else { [uint32]0 } }
}

# Square corners on Apply/Test/Watch, back to the Windows default on Reset.
[uint32]$corners = if ($Mode -eq 'Reset') { 0 } else { 1 }

if ($Mode -eq 'Watch') {
    # Setting the attribute is cheap and idempotent, so re-apply to every window each pass.
    while ($true) {
        foreach ($h in Get-ChromeWindows) {
            [void][DwmBorder]::SetBorder($h, $value)
            [void][DwmBorder]::SetCorners($h, $corners)
        }
        Start-Sleep -Seconds $IntervalSeconds
    }
}

$wins = Get-ChromeWindows

if ($Mode -eq 'List') {
    "Found $($wins.Count) Chrome window(s):"
    $i = 0
    foreach ($h in $wins) { "{0}: 0x{1:X}  {2}" -f $i, [int64]$h, [DwmBorder]::Title($h); $i++ }
    return
}

$targets = if ($Mode -eq 'Test') { @($wins | Select-Object -First 1) } else { $wins }

foreach ($h in $targets) {
    $hr = [DwmBorder]::SetBorder($h, $value)
    $hrc = [DwmBorder]::SetCorners($h, $corners)
    "{0}: border HRESULT 0x{1:X8}, corners HRESULT 0x{2:X8}  {3}" -f $Mode, $hr, $hrc, [DwmBorder]::Title($h)
}
