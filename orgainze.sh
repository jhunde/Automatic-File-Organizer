#!/bin/bash

folder_dir="Image Folder"

# Create an Image folder 
if [[ -d "$folder_dir" ]]; then
    echo "This '$folder_dir' already exist so, we're appending to it! 😉"
else
    mkdir "$folder_dir"
    echo "Folder is created! 🙌"
fi

# Move ALL of the file into Image Folder except ".sh" file
for file in *; do 
     if [[ -f "$file" && "$file" != *.sh ]]; then
        mv "$file" "$folder_dir"
    fi
done

# Navigate to the Image Folder
cd "$folder_dir"        
echo "Currenly inside '$folder_dir' 👀"


echo "Began organizing file, please be patient"
# Organize file by Month and Year
for file in *; do
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

# Run loading screen in parallel while task is executing
echo "All image files are done being organize! 🎉"

