setlocal EnableDelayedExpansion 
@echo off
REM for /f "usebackq tokens=1 delims= " %%i in (`fciv %console%\%gamename%.%verext% -sha1 ^| find /v "/"`) do set %verext%_shahash=%%i

for /f "usebackq tokens=1 delims= " %%i in (`fciv %console%\%gamename%.%verext% -sha1 ^| find /v "/"`) do set %verext%_shahash=%%i && for /f "usebackq tokens=1 delims= " %%i in (`fciv %console%\%gamename%.%verext% -md5  ^| find /v "/"`) do set %verext%_md5hash=%%i

echo md5 hash is %cue_md5hash% and sha1 hash is %cue_shahash%


REM echo sha1 hash is %cue_shahash% and md5 hash is cue_shahash
