# Live Photo Cleaner

A lightweight, standalone Windows Batch script that strips Live Photo and Motion Photo metadata from JPEG images (e.g. from iPhone, Samsung, or Google Camera). It removes the hidden video link and embedded video data using ExifTool, turning the image into a plain, standard JPEG, while restoring the original file creation and modification dates.

## Features

* **Cross-Device Detection:** Recognizes both Apple Live Photos (`ContentIdentifier` / `MediaGroupUUID`) and Samsung/Google Motion Photos (`XMP-GCamera:MotionPhoto`) in a single pass.
* **Full Cleanup:** Removes the MakerNotes block containing the Live Photo link, as well as any embedded video data appended to the JPEG trailer (Motion Photos).
* **Timestamp Preservation:** Restores the original file creation and modification dates after processing, so photos keep their correct place in your library.
* **Safe by Default:** Only edits files in place; ExifTool automatically keeps an untouched `_original` backup copy of every modified file.

## Prerequisites
Place the required executable file in the same directory as the script, or add it to your system `PATH`:

* **[ExifTool](https://exiftool.org/)** — Download the Windows executable zip, extract it, rename `exiftool(-k).exe` to `exiftool.exe`, and copy it into the script directory.

## Usage

1. Copy `live-photo-cleaner.bat` into the folder with your `.jpg` / `.jpeg` photos and `exiftool.exe`.
2. **Double-click** `live-photo-cleaner.bat` to scan and process all supported photos in the folder.
3. Wait for the confirmation beep and the "Done" message in the console window.

## Backup Files

Every modified photo gets an untouched backup copy next to it, using the following naming convention:
* `[FILENAME].jpg_original`
* `[FILENAME].jpeg_original`

These backups are used automatically to restore the original file dates and can be deleted manually once you've verified the results.
