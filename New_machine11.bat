@echo off
echo Gathering system information...

:: Get the computer name
set "computerName=%COMPUTERNAME%"

:: Write system information to a text file with the computer name
set outputFile="%computerName%_systemInfo.txt"

:: Get PC Manufacturer
echo Manufacturer:>>%outputFile%
powershell -command "Get-CimInstance Win32_ComputerSystem | Select-Object -ExpandProperty Manufacturer" >> %outputFile%

:: Get PC Model
echo Model:>>%outputFile%
powershell -command "Get-CimInstance Win32_ComputerSystem | Select-Object -ExpandProperty Model" >> %outputFile%

:: Get PC Serial Number
echo SerialNumber:>>%outputFile%
powershell -command "Get-CimInstance Win32_BIOS | Select-Object -ExpandProperty SerialNumber" >> %outputFile%

:: Get PC Model Name
echo Name:>>%outputFile%
powershell -command "Get-CimInstance Win32_ComputerSystem | Select-Object -ExpandProperty Name" >> %outputFile%

:: Get Processor Information
echo Processor:>>%outputFile%
powershell -command "Get-CimInstance Win32_Processor | Select-Object -ExpandProperty Name" >> %outputFile%

:: Get Windows Version
echo WindowsVersion:>>%outputFile%
powershell -command "Get-CimInstance Win32_OperatingSystem | Select-Object -ExpandProperty Caption" >> %outputFile%

:: Get Windows Serial Number
echo WindowsSerialNumber:>>%outputFile%
powershell -command "Get-CimInstance SoftwareLicensingService | Select-Object -ExpandProperty OA3xOriginalProductKey" >> %outputFile%

:: Get Storage Type and Size
echo StorageTypeAndSize:>>%outputFile%
powershell -command "Get-CimInstance Win32_DiskDrive | Select-Object Model, Size" >> %outputFile%

:: Get RAM Details
echo RAMDetails:>>%outputFile%
powershell -command "Get-CimInstance Win32_PhysicalMemory | Select-Object Manufacturer, PartNumber, Speed, Capacity" >> %outputFile%

:: Get Total Installed RAM
echo TotalInstalledRAM:>>%outputFile%
powershell -command "Get-CimInstance Win32_ComputerSystem | Select-Object -ExpandProperty TotalPhysicalMemory" >> %outputFile%

:: Get LAN Details
echo LANDetails:>>%outputFile%
powershell -command "Get-CimInstance Win32_NetworkAdapter | Where-Object { $_.NetEnabled -eq $true } | Select-Object Name, MACAddress, Manufacturer" >> %outputFile%

:: Get WiFi Details
echo WiFiDetails:>>%outputFile%
powershell -command "if (Test-Connection -ComputerName (hostname) -Count 1 -BufferSize 32 -Quiet) { Get-NetAdapter | Where-Object { $_.Status -eq 'Up' } | Select-Object Name, MacAddress, Manufacturer | Out-File -FilePath %outputFile% -Append } else { echo 'No WiFi connection detected.' >> %outputFile% }"

:: Get detailed network adapter information
echo Network Adapter Details:>>%outputFile%
powershell -command "Get-CimInstance Win32_NetworkAdapter | Select-Object AdapterType, Name, Installed, MACAddress, PowerManagementSupported, Speed, Manufacturer, NetConnectionStatus, Status, PNPDeviceID" >> %outputFile%

echo System information gathered successfully and saved to %outputFile%.
pause
