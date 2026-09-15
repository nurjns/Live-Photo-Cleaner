:: Version 1.0.0 - 15.09.2026 - @nurjns

@echo off
setlocal enabledelayedexpansion
title Live Photo Cleaner

set "SCRIPTDIR=%~dp0"
set "EXIFTOOL=%SCRIPTDIR%exiftool.exe"

if not exist "%EXIFTOOL%" (
	echo [FEHLER] exiftool.exe wurde nicht in "%SCRIPTDIR%" gefunden.
	echo Bitte exiftool.exe in denselben Ordner wie dieses Script legen.
	pause
	exit /b 1
)

echo Durchsuche "%SCRIPTDIR%." nach Live-/Motion-Photos ...
echo.

"%EXIFTOOL%" -P -m ^
	-if "$ContentIdentifier or $MediaGroupUUID or $XMP-GCamera:MotionPhoto or $MotionPhotoVersion" ^
	-MakerNotes:all= -trailer:all= ^
	-ext jpg -ext jpeg ^
	"%SCRIPTDIR%."

echo.
echo Stelle Erstellungs-/Aenderungsdatum aus den Original-Kopien wieder her ...

for %%O in ("%SCRIPTDIR%*.jpg_original" "%SCRIPTDIR%*.jpeg_original") do (
	if exist "%%O" (
		set "ORIGFILE=%%O"
		set "TARGET=!ORIGFILE:_original=!"
		if exist "!TARGET!" (
			"%EXIFTOOL%" -overwrite_original -TagsFromFile "%%O" "-FileCreateDate" "-FileModifyDate" "!TARGET!" >nul
		)
	)
)

powershell -c [console]::beep(500,200)
echo.
echo Fertig. Originale liegen als "_original"-Kopie daneben.
pause