REM  @echo off

REM This version I did on the 11th
REM And DOES work correctly in every way I can tell
REM Newer version
REM Sept 13th 2016
REM New functionality added

set gamelist=
set CDDRIVE=
SET CONSOLE=

setlocal EnableDelayedExpansion

REM If only one/the same one every time optical drive will be used at a time
REM you can set the CDDRIVE variable to a drive letter
REM such as CDDRIVE=D:
REM

if  [%1]==[] (goto :usagehelp) ELSE set gamelist=%1
echo value is %gamelist%
pause

if [%2]==[] (goto :usagehelp) ELSE SET CDDRIVE=%2
if [%3]==[] (goto :usagehelp) ELSE SET CONSOLE=%3

echo gamelist is %gamelist%
echo drive is %CDDRIVE%
echo console is %CONSOLE%

pause
if defined gamelist  goto :cotinueon ELSE goto :usagehelp


:cotinueon
for /f "tokens=1" %%i in (%gamelist%) do (SET GAMENAME=%%i) && (call :RIPVERIFY)
goto eof


:RIPVERIFY
echo Insert  %GAMENAME% for %CONSOLE% into drive %CDDRIVE%...
pause

REM blank out the file-ext variable to set a fresh value for each game
REM on further thought, I could just set the ext variable to bin if %console% is PS1
REM and only do the bin-or-iso-detection on PS2 insertion
REM using an if/else

set FILE-EXT=

REM Get information on disc...
REM I set this mode to verify so it would work with a non-writer optical drive.
REM It doesn't seem to work with "discovery" mode
REM It seems "read" mode will also work. I don't think there's a an advantage of one over the other
ImgBurn.exe /mode verify /src %CDDRIVE%  /info "gameinfo\%GAMENAME%_%CONSOLE%.txt" /CLOSEINFO /WAITFORMEDIA

pause
if exist "gameinfo\%GAMENAME%_%CONSOLE%.txt" (
  for /f "usebackq tokens=3 delims= " %%z in (`type gameinfo\%GAMENAME%_%CONSOLE%.txt ^| find /i "current profile"`) do set DISCTYPE=%%z)
  else (
    echo could not find text file
    )

pause


REM Based on the extracted disc type, set the file extension to either "bin" or "ISO"
REM new-and-improved if/else statement: i forgot the "set" part in the ISO set
REM and set the CUE extension variable for verifying

REM if /i "%CONSOLE%" == "ps1" (set FILE-EXT=BIN && set VEREXT=CUE)
if /i "%DISCTYPE%" == "cd-rom" (
  set FILE-EXT=BIN && set VEREXT=CUE)
  else (
    SET FILE-EXT=ISO && set VEREXT=ISO)

echo value of FILE-EXT is %FILE-EXT%
echo value of VEREXT is %VEREXT%
pause

REM made it all the way to here and couldn't find the s:\playstation-rips directory, of course
REM I ended up just using the regular % ~ d p 0 as the solution (that dp0 expands, even in REMs)

ImgBurn.exe /mode read /src %CDDRIVE%  /dest %~dp0%CONSOLE%\%GAMENAME%_%CONSOLE%.%FILE-EXT% /start /CLOSESUCCESS /WAITFORMEDIA
echo error level is %errorlevel%
REM pause


IF %ERRORLEVEL% NEQ 0 GOTO ERROR-OCCURRED

REM ImgBurn gripes if the verify is against the bin versus the cue file, so verify should done against the .cue

ImgBurn.exe /mode verify /src %CDDRIVE% /dest %~dp0%CONSOLE%\%GAMENAME%_%CONSOLE%.%VEREXT% /start /eject yes /CLOSESUCCESS /WAITFORMEDIA
echo error level is %errorlevel%

IF %ERRORLEVEL% NEQ 0 GOTO ERROR-OCCURRED

REM fciv %~dp0%CONSOLE%\%GAMENAME%_%CONSOLE%.%FILE-EXT% sha1 | find /v "/" >> %~dp0gameinfo\sha1-game-hashes_%CONSOLE%.txt

for /f "usebackq tokens=1 delims= " %%i in (`fciv %console%\%gamename%_%console%.%verext% -sha1 ^| find /v "/"`) do set shahash=%%i
for /f "usebackq tokens=1 delims= " %%i in (`fciv %CONSOLE%\%GAMENAME%_%console%.%VEREXT% -md5  ^| find /v "/"`) do set md5hash=%%i



echo sha1 hash is %verext%_%shahash% and md5 hash is %verext%_%md5hash%

if not exist gameslog.csv (
  echo console,game_name,file-type,sha1_hash,date,time > gameslog.csv && echo %console%,%gamename%,%FILE-EXT%,%shahash%,%date%,%time% >> gameslog.csv
  ) else (
    echo %console%,%gamename%,%FILE-EXT%,%shahash%,%date%,%time% >> gameslog.csv
    )


REM SET GAMENAME=

goto eof

:usagehelp
echo advib is not smart enough to figure this out on its own
echo Please enter command in form:
echo advib (text file list of games) (CD drive letter) (console name)
echo example:
echo advib ps2gamelist.txt d: ps2
echo ps2gamelist.txt is a list of ps2 games, one per line
echo advib has trouble with spaces and other special characters in the game list file


goto eof

:ERROR-OCCURRED

ECHO An error occurred with game %GAMENAME%, disc must be re-done
ECHO error code returned was %errorlevel%

goto eof

:eof
