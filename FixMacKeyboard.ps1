# Check for currently connected Bluetooth keyboards
$keyboardConnected = Get-CimInstance -Namespace root\cimv2 -ClassName Win32_PnPEntity |
Where-Object {
    $_.PNPClass -eq "Keyboard" -and
    $_.Name -match "Bluetooth" -and
    $_.DeviceID -match "BTHENUM"
}

Write-Host "Detected connected Bluetooth Keyboards:"
$keyboardConnected | Format-Table Name, Status, DeviceID

# Paths to Key Mapper executables
$keyMapperFolder = "C:\misc\keymapper-4.11.4-Windows-x86_64"
$keymapperExe = Join-Path $keyMapperFolder "keymapper.exe"
$keymapperdExe = Join-Path $keyMapperFolder "keymapperd.exe"

# Launch Key Mapper only if Bluetooth keyboard is connected
# Start keymapperd.exe better with elevated privileges -Verb RunAs

if ($keyboardConnected) {
    Write-Host "Bluetooth keyboard detected. Launching Key Mapper..."

    Start-Process -FilePath $keymapperdExe
    Start-Process -FilePath $keymapperExe
} else {
    Write-Host "No Bluetooth keyboard detected."
}
