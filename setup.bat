@echo off

echo Press any key to install windows

pause >nul

title Preparing to Install...

echo Diskpart Config

echo 1. Use the diskpart script.

echo 2. Use the diskpart manual.

set /p diskpartpath=

if %diskpartpath% == 1 goto scr

if %diskpartpath% == 2 goto man

:scr

diskpart /s V:\diskpartscript.txt

goto installpath

:man

diskpart

goto installpath

:installpath

echo Select the path of install.wim / install.esd file

set /p installfile=

goto index

:index

echo Select the index:

dism /get-wiminfo /wimfile:%installfile%

set /p indexcode=

title Installing...

goto install

:install

echo Installing windows...

dism /apply-image /imagefile:%installfile% /applydir:C:\ /index:%indexcode%

bcdboot C:\Windows /s W:

echo Press any key to reboot...

pause >nul

echo Done. Rebooting...

wpeutil reboot