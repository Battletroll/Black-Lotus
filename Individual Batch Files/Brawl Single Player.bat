@echo off
::Sets the width and Hight of the batch screen
MODE 95, 30

::Setup for testing
set _climb=10000
set _threads=8
set _effect1=Rally All 1
set _effect2=Rally All 2
set _effect3=Rally All 3
set _enemy=Rally1 Attack


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

GOTO BRAWL3



:BRAWL
::This runs a battleground effect Offensive brawl
::Day 1
CLS
ECHO ~~~~~~~~Black Lotus BRAWL~~~~~~~~~~~
ECHO(
ECHO    Offensive %_effect1% BRAWL for: %_member%
ECHO(
ECHO(
CALL tuo "%_ydeck%" "%_enemy%" gw ordered -e "%_effect1%" -t %_threads% fund 2500 -o="%~dp0data"\%_member%.txt climb %_climb%>>temp.txt
for /F "delims=" %%t in ('findstr "Optimized Deck:" temp.txt') do set _temp=%%t
CD Results
ECHO %_member%,%Date%,%_effect1%,%_temp%>>%_member%_Offensive_Brawl.txt
CD %~dp0
del temp.txt


::This runs a battleground effect Defensive brawl
::Day 1
set _enemy=Rally1 Defend

CLS
ECHO ~~~~~~~~Black Lotus BRAWL~~~~~~~~~~~
ECHO(
ECHO    Defensive %_effect1% BRAWL for: %_member%
ECHO(
ECHO(
CALL tuo "%_ydeck%" "%_enemy%" gw defense -e "%_effect1%" -t %_threads% fund 2500 -o="%~dp0data"\%_member%.txt climb %_climb%>>temp.txt
for /F "delims=" %%t in ('findstr "Optimized Deck:" temp.txt') do set _temp=%%t
CD Results
ECHO %_member%,%Date%,%_effect1%,%_temp%>>%_member%_Defensive_Brawl.txt
CD %~dp0
del temp.txt

::This runs a battleground effect Offensive brawl
::Day 2
set _enemy=Rally2 Attack
CLS
ECHO ~~~~~~~~Black Lotus BRAWL~~~~~~~~~~~
ECHO(
ECHO    Offensive %_effect2% BRAWL for: %_member%
ECHO(
ECHO(
CALL tuo "%_ydeck%" "%_enemy%" gw ordered -e "%_effect2%" -t %_threads% fund 2500 -o="%~dp0data"\%_member%.txt climb %_climb%>>temp.txt
for /F "delims=" %%t in ('findstr "Optimized Deck:" temp.txt') do set _temp=%%t
CD Results
ECHO %_member%,%Date%,%_effect2%,%_temp%>>%_member%_Offensive_Brawl.txt
CD %~dp0
del temp.txt

::This runs a battleground effect Defensive brawl
::Day 2
set _enemy=Rally2 Defend

CLS
ECHO ~~~~~~~~Black Lotus BRAWL~~~~~~~~~~~
ECHO(
ECHO    Defensive %_effect2% BRAWL for: %_member%
ECHO(
ECHO(
CALL tuo "%_ydeck%" "%_enemy%" gw defense -e "%_effect2%" -t %_threads% fund 2500 -o="%~dp0data"\%_member%.txt climb %_climb%>>temp.txt
for /F "delims=" %%t in ('findstr "Optimized Deck:" temp.txt') do set _temp=%%t
CD Results
ECHO %_member%,%Date%,%_effect2%,%_temp%>>%_member%_Defensive_Brawl.txt
CD %~dp0
del temp.txt


:BRAWL3
::This runs a battleground effect Offensive brawl
::Day 3
set _enemy=Rally3 Attack
CLS
ECHO ~~~~~~~~Black Lotus BRAWL~~~~~~~~~~~
ECHO(
ECHO    Offensive %_effect3% BRAWL for: %_member%
ECHO(
ECHO(
CALL tuo "%_ydeck%" "%_enemy%" gw ordered -e "%_effect3%" -t %_threads% fund 2500 -o="%~dp0data"\%_member%.txt climb %_climb%>>temp.txt
for /F "delims=" %%t in ('findstr "Optimized Deck:" temp.txt') do set _temp=%%t
CD Results
ECHO %_member%,%Date%,%_effect3%,%_temp%>>%_member%_Offensive_Brawl.txt
CD %~dp0
del temp.txt

::This runs a battleground effect Defensive brawl
::Day 3
set _enemy=Rally3 Defend

CLS
ECHO ~~~~~~~~Black Lotus BRAWL~~~~~~~~~~~
ECHO(
ECHO    Defensive %_effect3% BRAWL for: %_member%
ECHO(
ECHO(
CALL tuo "%_ydeck%" "%_enemy%" gw defense -e "%_effect3%" -t %_threads% fund 2500 -o="%~dp0data"\%_member%.txt climb %_climb%>>temp.txt
for /F "delims=" %%t in ('findstr "Optimized Deck:" temp.txt') do set _temp=%%t
CD Results
ECHO %_member%,%Date%,%_effect3%,%_temp%>>%_member%_Defensive_Brawl.txt
CD %~dp0
del temp.txt

GOTO subroutine

:subroutine


GOTO :eof