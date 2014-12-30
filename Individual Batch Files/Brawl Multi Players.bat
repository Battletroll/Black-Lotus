@echo off
::Sets the width and Hight of the batch screen
MODE 95, 30
::Setup for testing
set _climb=100
set _threads=8
set _effect1=Enhance All Counter 2
set _effect2=Enhance All Enfeeble 2
set _effect3=Enhance All Protect 2
set _enemy=TopBrawl


::Update the Cards and mission.xml files 
CD data
Call Update.bat
CD..

::The reads the members name in a file called members.
::You can have one member or 50+ members
cls
setlocal ENABLEDELAYEDEXPANSION
FOR /f "tokens=*" %%G IN (members.txt) DO (
	SET _member=%%G
	call :getcards "%%G"
)
Endlocal

::get player's current deck from owncards file:
:getcards
findstr /g "Current Deck:" "%~dp0data"\%_member%.txt>>temp.txt
SET _current=CURRENT: 
SetLocal EnableDelayedExpansion

::this parses out any colons and flips #2 to (2)
set content=
for /F "delims=" %%i in (temp.txt) do set content=!content! %%i
SET _result=%content:*: =%
SET _remove=%_result:*: =%
SET _final=%_remove:#2=(2)%

::This takes our source file and makes it customdecks.txt
copy "%~dp0data"\SOURCE.txt "%~dp0data"\customdecks.txt
echo.>>"%~dp0data"\customdecks.txt
SET _current=%_current%%_final%
echo %_current%>>"%~dp0data"\customdecks.txt
EndLocal

::This sets _ydeck to the current members deck for simulations.
SET _ydeck=CURRENT

GOTO BRAWL


:BRAWL
::This runs a battleground effect Offensive brawl
::Day 1
CLS
ECHO ~~~~~~~~Black Lotus BRAWL~~~~~~~~~~~
ECHO(
ECHO    Offensive %_effect1% BRAWL for: %_member%
ECHO(
ECHO(
CALL tuo "%_ydeck%" "%_enemy%" gw ordered -e "%_effect1%" -t %_threads% -o="%~dp0data"\%_member%.txt climb %_climb%>>temp.txt
for /F "delims=" %%t in ('findstr "Optimized Deck:" temp.txt') do set _temp=%%t
CD Results
ECHO %_member%,%Date%,%_effect1%,%_temp%>>Offensive_Brawl.txt
CD %~dp0
del temp.txt


::This runs a battleground effect Defensive brawl
::Day 1
CLS
ECHO ~~~~~~~~Black Lotus BRAWL~~~~~~~~~~~
ECHO(
ECHO    Defensive %_effect1% BRAWL for: %_member%
ECHO(
ECHO(
CALL tuo "%_ydeck%" "%_enemy%" gw defense -e "%_effect1%" -t %_threads% -o="%~dp0data"\%_member%.txt climb %_climb%>>temp.txt
for /F "delims=" %%t in ('findstr "Optimized Deck:" temp.txt') do set _temp=%%t
CD Results
ECHO %_member%,%Date%,%_effect1%,%_temp%>>Defensive_Brawl.txt
CD %~dp0
del temp.txt

::This runs a battleground effect Offensive brawl
::Day 2
CLS
ECHO ~~~~~~~~Black Lotus BRAWL~~~~~~~~~~~
ECHO(
ECHO    Offensive %_effect2% BRAWL for: %_member%
ECHO(
ECHO(
CALL tuo "%_ydeck%" "%_enemy%" gw ordered -e "%_effect2%" -t %_threads% -o="%~dp0data"\%_member%.txt climb %_climb%>>temp.txt
for /F "delims=" %%t in ('findstr "Optimized Deck:" temp.txt') do set _temp=%%t
CD Results
ECHO %_member%,%Date%,%_effect2%,%_temp%>>Offensive_Brawl.txt
CD %~dp0
del temp.txt

::This runs a battleground effect Defensive brawl
::Day 2
CLS
ECHO ~~~~~~~~Black Lotus BRAWL~~~~~~~~~~~
ECHO(
ECHO    Defensive %_effect2% BRAWL for: %_member%
ECHO(
ECHO(
CALL tuo "%_ydeck%" "%_enemy%" gw defense -e "%_effect2%" -t %_threads% -o="%~dp0data"\%_member%.txt climb %_climb%>>temp.txt
for /F "delims=" %%t in ('findstr "Optimized Deck:" temp.txt') do set _temp=%%t
CD Results
ECHO %_member%,%Date%,%_effect2%,%_temp%>>Defensive_Brawl.txt
CD %~dp0
del temp.txt

::This runs a battleground effect Offensive brawl
::Day 3
CLS
ECHO ~~~~~~~~Black Lotus BRAWL~~~~~~~~~~~
ECHO(
ECHO    Offensive %_effect3% BRAWL for: %_member%
ECHO(
ECHO(
CALL tuo "%_ydeck%" "%_enemy%" gw ordered -e "%_effect3%" -t %_threads% -o="%~dp0data"\%_member%.txt climb %_climb%>>temp.txt
for /F "delims=" %%t in ('findstr "Optimized Deck:" temp.txt') do set _temp=%%t
CD Results
ECHO %_member%,%Date%,%_effect3%,%_temp%>>Offensive_Brawl.txt
CD %~dp0
del temp.txt

::This runs a battleground effect Defensive brawl
::Day 3
CLS
ECHO ~~~~~~~~Black Lotus BRAWL~~~~~~~~~~~
ECHO(
ECHO    Defensive %_effect3% BRAWL for: %_member%
ECHO(
ECHO(
CALL tuo "%_ydeck%" "%_enemy%" gw defense -e "%_effect3%" -t %_threads% -o="%~dp0data"\%_member%.txt climb %_climb%>>temp.txt
for /F "delims=" %%t in ('findstr "Optimized Deck:" temp.txt') do set _temp=%%t
CD Results
ECHO %_member%,%Date%,%_effect3%,%_temp%>>Defensive_Brawl.txt
CD %~dp0
del temp.txt

GOTO subroutine

:subroutine


GOTO :eof