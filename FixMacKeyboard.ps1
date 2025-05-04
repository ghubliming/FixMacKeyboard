# Detect Bluetooth HID or Keyboard Devices
$keyboardConnected = Get-PnpDevice | Where-Object {
    ($_.Class -in @("Keyboard", "HIDClass")) -and
    (
        $_.FriendlyName -match "Bluetooth" -or
        $_.FriendlyName -match "HID Keyboard Device" -or
        $_.FriendlyName -match "Bluetooth HID Device"
    ) -and
    $_.InstanceId -match "BTHENUM"
}

# Paths to Key Mapper executables
$keyMapperFolder = "C:\misc\keymapper-4.11.4-Windows-x86_64"
$keymapperExe = Join-Path $keyMapperFolder "keymapper.exe"
$keymapperdExe = Join-Path $keyMapperFolder "keymapperd.exe"

# If Bluetooth keyboard found, run Key Mapper components
if ($keyboardConnected) {
    Write-Host "Bluetooth keyboard detected. Launching Key Mapper..."

    # Start keymapperd.exe better with elevated privileges -Verb RunAs
    Start-Process -FilePath $keymapperdExe 

    # Start keymapper.exe normally
    Start-Process -FilePath $keymapperExe
} else {
    Write-Host "No Bluetooth keyboard detected."
}
