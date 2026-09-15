:: Version 1.0.0 - 2026-09-15 - @nurjns

@echo off
setlocal enabledelayedexpansion
title Live Photo Cleaner

set "SCRIPTDIR=%~dp0"
set "EXIFTOOL=%SCRIPTDIR%exiftool.exe"

where exiftool >nul 2>&1
if errorlevel 1 (
	echo [ERROR] ExifTool not found^^! Please ensure ExifTool is in your PATH.
	pause & exit /b 1
)

echo Searching "%SCRIPTDIR%." for Live/Motion Photos ...
echo.

"%EXIFTOOL%" -P -m ^
	-if "$ContentIdentifier or $MediaGroupUUID or $XMP-GCamera:MotionPhoto or $MotionPhotoVersion" ^
	-MakerNotes:all= -trailer:all= ^
	-ext jpg -ext jpeg ^
	"%SCRIPTDIR%."

echo.
echo Restoring creation/modification date from the original copies ...

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
echo Done. Originals are kept as "_original" copies alongside.
pause
