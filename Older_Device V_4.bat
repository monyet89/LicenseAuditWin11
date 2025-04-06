@echo off
echo Gathering system information...


:: Get the computer name
set "computerName=%COMPUTERNAME%"

:: Write system information to a text file with the computer name
set outputFile="%computerName%_systemInfo.txt"


:: Get PC Manufacturer
echo Manufacturer:>>%outputFile%
wmic computersystem get manufacturer | findstr /v /c:"Manufacturer" >> %outputFile%

:: Get PC Type
echo Model:>>%outputFile%
wmic computersystem get model | findstr /v /c:"Model" >> %outputFile%

:: Get PC Serial Number
echo SerialNumber:>>%outputFile%
wmic bios get serialnumber | findstr /v /c:"SerialNumber" >> %outputFile%

:: Get PC Model Name
echo Name:>>%outputFile%
wmic computersystem get name | findstr /v /c:"Name" >> %outputFile%

:: Get Processor Information
echo Processor:>>%outputFile%
wmic cpu get name | findstr /v /c:"Name" >> %outputFile%

:: Get Windows Version
echo WindowsVersion:>>%outputFile%
wmic os get caption | findstr /v /c:"Caption" >> %outputFile%

:: Get Windows Serial Number
echo WindowsSerialNumber:>>%outputFile%
wmic path softwarelicensingservice get OA3xOriginalProductKey | findstr /v /c:"OA3xOriginalProductKey" >> %outputFile%

:: Get Storage Type and Size
echo StorageTypeAndSize:>>%outputFile%
wmic diskdrive get model,size | findstr /v /c:"Model" >> %outputFile%

:: Get RAM Details
echo RAMDetails:>>%outputFile%
wmic memorychip get capacity,manufacturer,partnumber,speed | findstr /v /c:"Capacity" >> %outputFile%

:: Get Total Installed RAM
echo TotalInstalledRAM:>>%outputFile%
wmic computersystem get totalphysicalmemory | findstr /v /c:"TotalPhysicalMemory" >> %outputFile%

:: Get LAN Details
echo LANDetails:>>%outputFile%
wmic nic where "NetEnabled=true" get name,macaddress,manufacturer | findstr /v /c:"Name" >> %outputFile%

:: Get WiFi Details
echo WiFiDetails:>>%outputFile%
netsh wlan show interfaces | findstr /c:"State" | findstr /c:"connected"
if %errorlevel%==0 (
    netsh wlan show interfaces | findstr /r /c:"^\s*SSID" /c:"^\s*BSSID" /c:"^\s*Signal" /c:"^\s*Radio" /c:"^\s*Channel" /c:"^\s*Receive" /c:"^\s*Transmit" /c:"^\s*802.11" /c:"^\s*Type" >> %outputFile%
) else (
    echo No WiFi connection detected. >> %outputFile%
)



:: Get detailed network adapter information
echo Network Adapter Details:>>%outputFile%
wmic nic get AdapterType,Name,Installed,MACAddress,PowerManagementSupported,Speed,Manufacturer,NetConnectionStatus,Status,PNPDeviceID | findstr /v /c:"AdapterType" >> %outputFile%
echo System information gathered successfully and saved to %outputFile%.
pause
