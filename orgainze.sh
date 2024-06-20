#!/bin/bash

# Create an Image folder 
mkdir "Image Folder"

# Move all of the jpeg file into Image_folder
mv *.jpg "Image Folder"

# Navigate to the Image Folder
cd "Image Folder" || exit           

# Organize file by Month and Year
for file in *.jpg; do

    if [[ -f "$file" ]]; then
        # Get the year and month from EXIF data
        year=$(exiftool -d "%Y" -DateTimeOriginal -S -s "$file")
        month=$(exiftool -d "%m" -DateTimeOriginal -S -s "$file")
        
        # If EXIF data is not available, fallback to file modification date
        if [[ -z "$year" ]]; then
            year=$(stat -c %y "$file" | cut -d'-' -f1)
        fi

        if [[ -z "$month" ]]; then
            month=$(stat -c %y "$file" | cut -d'-' -f2)
        fi

        # Create directories for the year and month if they don't exist
        mkdir -p "$year/$month"
        
        # Move files to the appropriate directories
        mv "$file" "$year/$month" 
    fi
done
echo "All image files are done being organize!"

