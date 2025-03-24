@echo off

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Please run this script as Administrator!
    pause
    exit /b
)

echo Current permissions for D:\
icacls D:\

:: Deny write permission to LOCAL SERVICE (S-1-5-19)
echo.
echo Adding write deny permission for LOCAL SERVICE (this might take a while)...
icacls D:\ /deny *S-1-5-19:(W)

:: Display permissions again to verify
echo.
echo Updated permissions for D:\
icacls D:\

:: Restart Windows Audio service
echo.
echo Restarting Windows Audio service...
net stop "Windows Audio"
net start "Windows Audio"

echo.
echo All done. You should now be able to delete the file once and for all.
pause
