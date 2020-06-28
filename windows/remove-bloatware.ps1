# Remove bloatware


echo "Removing bloatware:"

# Xbox
Get-AppxPackage *Microsoft.XboxApp* -AllUsers | Remove-AppxPackage

# Xbox Game Bar
Get-AppxPackage *Microsoft.XboxGameOverlay* -AllUsers | Remove-AppxPackage

# Xbox Gaming Overlay
Get-AppxPackage *Microsoft.XboxGamingOverlay* -AllUsers | Remove-AppxPackage

# Xbox Identity Provider
Get-AppxPackage *Microsoft.XboxIdentityProvider* -AllUsers | Remove-AppxPackage

# Xbox Speech to Text Overlay
Get-AppxPackage *Microsoft.XboxSpeechToTextOverlay* -AllUsers | Remove-AppxPackage

# Your Phone
Get-AppxPackage *Microsoft.YourPhone* -AllUsers | Remove-AppxPackage

# Maps
Get-AppxPackage *Microsoft.WindowsMaps* -AllUsers | Remove-AppxPackage

# Get Help
Get-AppxPackage *Microsoft.GetHelp* -AllUsers | Remove-AppxPackage

# People
Get-AppxPackage *Microsoft.People* -AllUsers | Remove-AppxPackage

# 3D Builder
Get-AppxPackage *Microsoft.3DBuilder* -AllUsers | Remove-AppxPackage

# Bing Weather
Get-AppxPackage *Microsoft.BingWeather* -AllUsers | Remove-AppxPackage

# Tips
Get-AppxPackage *Microsoft.Getstarted* -AllUsers | Remove-AppxPackage

# Messaging
Get-AppxPackage *Microsoft.Messaging* -AllUsers | Remove-AppxPackage

# Mixed Reality Viewer
Get-AppxPackage *Microsoft.Microsoft3DViewer* -AllUsers | Remove-AppxPackage

# Mixed Reality Portal
Get-AppxPackage *Microsoft.MixedReality.Portal* -AllUsers | Remove-AppxPackage

# My Office
Get-AppxPackage *Microsoft.MicrosoftOfficeHub* -AllUsers | Remove-AppxPackage

# Sticky Notes
Get-AppxPackage *Microsoft.MicrosoftStickyNotes* -AllUsers | Remove-AppxPackage

# OneNote
Get-AppxPackage *Microsoft.Office.OneNote* -AllUsers | Remove-AppxPackage

# Paid Wi-Fi & Cellular
Get-AppxPackage *Microsoft.OneConnect* -AllUsers | Remove-AppxPackage

# Outlook
Get-AppxPackage *Microsoft.Outlook.DesktopIntegrationServices* -AllUsers | Remove-AppxPackage

# Skype
Get-AppxPackage *Microsoft.SkypeApp* -AllUsers | Remove-AppxPackage

# Microsoft Pay
Get-AppxPackage *Microsoft.Wallet* -AllUsers | Remove-AppxPackage

# Mail & Calendar
Get-AppxPackage *Microsoft.windowscommunicationsapps* -AllUsers | Remove-AppxPackage

# Feedback Hub
Get-AppxPackage *Microsoft.WindowsFeedbackHub* -AllUsers | Remove-AppxPackage

# Groove Music
Get-AppxPackage *Microsoft.ZuneMusic* -AllUsers | Remove-AppxPackage

# Movies & TV
Get-AppxPackage *Microsoft.ZuneVideo* -AllUsers | Remove-AppxPackage

echo "Finished removing bloatware."
