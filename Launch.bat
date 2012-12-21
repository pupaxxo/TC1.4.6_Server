@ECHO OFF

:: Maximum amount of Ram to use to run the server. Limited at 1GB for 32 Bit Java
set MAXRAM=4G



:: Don't edit past this point :: Don't edit past this point :: Don't edit past this point ::
 
set JVM_VERSION=""
if $SYSTEM_os_arch==x86 (
  set JVM_VERSION=32
) else (
  set JVM_VERSION=64
)
 
set TEMP_FILE=%TEMP%\javaCheck%RANDOM%%TIME:~9,5%.txt
 
java -version 2>%TEMP_FILE%
FOR /F "tokens=*" %%i in (%TEMP_FILE%) do (
  echo %%i | find "HotSpot" >nul
  if not errorlevel 1 (
    echo %%i | find "64-Bit" >nul
    if not errorlevel 1 (
      set JVM_VERSION=64
    ) else (
      set JVM_VERSION=32
    )
  )
)
 
del %TEMP_FILE%
 
if %JVM_VERSION%==32 (
echo Detected 32 Bit Java - Running on 1GB of Ram
java -Xmx1G -jar minecraft_server.jar nogui
) else (
echo Detected 64 Bit Java - Running on 2GB of Ram
java -Xmx%MAXRAM% -jar minecraft_server.jar nogui
)
PAUSE