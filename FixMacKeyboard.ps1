# Simple and reliable Bluetooth keyboard detector and launcher
# Check for active Bluetooth HID device using the device's connection status

# Get Bluetooth keyboard connection status - looking specifically for connected devices
$activeBtKeyboard = Get-PnpDevice | Where-Object {
    ($_.Class -eq "Bluetooth" -or $_.Class -eq "HIDClass") -and
    ($_.FriendlyName -like "*keyboard*" -or $_.FriendlyName -like "*Bluetooth HID*") -and
    $_.Status -eq "OK" -and
    # Only consider a device connected if it has an active connection
    $_.Problem -eq 0
}

# Path to Key Mapper
$keyMapperFolder = "C:\misc\keymapper-4.11.4-Windows-x86_64"
$keymapperExe = Join-Path $keyMapperFolder "keymapper.exe"
$keymapperdExe = Join-Path $keyMapperFolder "keymapperd.exe"

# Check result and take action
if ($activeBtKeyboard) {
    Write-Host "Active Bluetooth keyboard detected:"
    $activeBtKeyboard | ForEach-Object {
        Write-Host "- $($_.FriendlyName) is connected"
    }
    
    # Start Key Mapper
    Start-Process -FilePath $keymapperdExe
    Start-Process -FilePath $keymapperExe
} else {
    Write-Host "No active Bluetooth keyboard detected."
}