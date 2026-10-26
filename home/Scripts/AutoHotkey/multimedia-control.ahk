#Requires AutoHotkey v2.0

; --- CONFIGURATION PATHS ---
svvPath := "C:\Tools\SoundVolumeView\SoundVolumeView.exe"

; Target names or descriptions as recognized by SoundVolumeView
tv_qcq95s := "QCQ95S"
klipsch   := "SPDIF Interface"   ; Or "2- Klipsch R-15PM"

; Helper function for display switching
SwitchDisplay(modeText, modeNum) {
    try {
        Run("DisplaySwitch.exe " . modeText)
    }
    Run("DisplaySwitch.exe " . modeNum)
}

; --- COMBO MACROS ---
; Ctrl + Shift + Alt + T -> TV Mode (Secondary Display + QCQ95S TV Audio)
^+!t::
{
    SwitchDisplay("/external", 4)
    Run(svvPath . ' /SetDefault "' . tv_qcq95s . '" 0')
    Run(svvPath . ' /SetDefault "' . tv_qcq95s . '" 2')
}

; --- DISPLAY CONTROLS ---
^+!b::SwitchDisplay("/clone", 2)            ; Ctrl + Shift + Alt + B -> Both Displays (Clone)
^+!p::SwitchDisplay("/internal", 1)         ; Ctrl + Shift + Alt + P -> Primary Display Only
^+!s::SwitchDisplay("/external", 4)         ; Ctrl + Shift + Alt + S -> Secondary Display Only
^+!e::SwitchDisplay("/extend", 3)           ; Ctrl + Shift + Alt + E -> Extend Displays

; --- AUDIO CONTROLS ---
^+!1::                                      ; Ctrl + Shift + Alt + 1 -> QCQ95S (TV Audio)
{
    Run(svvPath . ' /SetDefault "' . tv_qcq95s . '" 0')
    Run(svvPath . ' /SetDefault "' . tv_qcq95s . '" 2')
}

^+!2::                                      ; Ctrl + Shift + Alt + 2 -> Klipsch R-15PM
{
    Run(svvPath . ' /SetDefault "' . klipsch . '" 0')
    Run(svvPath . ' /SetDefault "' . klipsch . '" 2')
}

; --- VOLUME & APPS ---
^+!v::SoundSetVolume(100)                   ; Ctrl + Shift + Alt + V -> Master Volume 100%
^+!f::Run('C:\Program Files\Google\Chrome\Application\chrome.exe --start-fullscreen "https://www.twitch.tv/fuslie"')