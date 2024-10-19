# Objective

We want to automate a shell script file that allows us to organize our files in our computer **in our current direcotry** so that it may be nice, neat and easy to access.

In this project I will be using it to organize image file so the it may be sorted in its' proper folder but feel free to make the necessary adjustment to organize any other files besides `.jpg`

# Flowchart

> This is how the `Image Folder` should look after running the organized file. Remember, `Years`, `Months`, and `Image files would be here` are labeled to indicate the layers and are not actual folders.
>
> The folders are `Image Folder` and files inside `Year`, `Months`, and `Image file would be here` layers

```mermaid
flowchart TD

	ind[🗂️ Image Folder]-->Years
	subgraph Years
	y0[📁 2022]
	y1[📁 2023]
	y2[📁 2024]
	end

	Years-->Months
	subgraph Months
	f0[📂 01]
	f1[📂 02]
	f2[📂 03]
	f3[📂 04]
	f4[📂 05]
	f5[📂 06]
	f6[📂 07]
	f7[📂 08]
	f8[📂 09]
	f9[📂 10]
	f10[📂 11]
	f11[📂 12]
	end

	f0-->p0[📄 .jpg]
	subgraph Image files would be here
	p0
	p1[📄 .png]
	p2[📄 .pdf]
	end
```

---

# **Required Installation**

You will need to install **ExifTool**.

> **Note**:
>
> **ExifTool** is a free and open-source software program for reading, writing, and manipulating image, audio, video, and PDF metadata.
> [Reference to ExifTool Documentation](https://exiftool.org/)

## For Ubuntu/Debian:

```bash
sudo apt-get install libimage-exiftool-perl
```

## For MacOS (using Homebrew):

```bash
brew install exiftool
```

## For Windows

1. **Download** the appropriate `.zip` file based on your system's processor architecture
2. **Extract** the contents of the `.zip` file
3. **Open** the extracted folder and **rename the executable** file to `exiftool.exe`.
4. **Add the executable to your system's PATH:**
   - Go to the **Windows Start Menu** and search for "View Advanced System Settings"
   - Select **Environment Variables**
   - Under **System Variables**, double click to select `Path` and click **Edit**.
   - Click **New**, then paste the directory path of the renamed `exiftool.exe` file.
   - Click **OK** to close all dialog boxes.
5. **Restart** your terminal and type `exiftool` to verify the installation.

**A helpful YouTube tutorial walkthrough:** [How to Install Exiftool on Windows 10](https://www.youtube.com/watch?v=Ku1Nx-kl7RM)

---

# Step 1

Locate to the director that you want to be organized.
Then create a script file here. For this project we will be using `bash`

- You may this do by opening up your favorite editor then title it and saving it as a `.sh`
  - Example: `organize_file.sh`
- You may also do this is a `bash` terminal by doing the following:
  - `nano organize_file.sh` then start coding. **Be sure to save your file after finishing!**

# Step 2

In your `organize_file.sh` file include the a shebang `#!/bin/bash` because this will indicate that this file will be a bash script.

We create a `Image Folder` were we would store all of our `.jpge` (but of course as mentioned previously feel free to include other image file extensions like `.pdf`, `.png`,`.gif`, etc.).

```bash
mkdir "Image Folder"
```

Let's move all of our `.jpg` files into to the `Image Folder`.

```bash
mv *.jpg "Image Folder"
```

Then we will navigate to the directory we previously create. If it doesn't exist then we will exit.

```bash
cd "Image File" || exit
```

# Step 3

Now we run for loops using the information retrieved from the image files of all the images. We will be using `exiftool` for this part so be sure that you've installed the proper tool. Check the **Required Installation** of you haven't done so.

```bash
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
```

# Permission

> You will need to grant permission to run the `organize_file.sh` file correctly

1. Open a terminal
   - You will need to right click terminal and **_Run as an administrator_**
2. Change directory into the location where `organized_file.sh` is saved
   - Remember this is the directory that will be organized
3. `chmod +x sort.sh`

> **Note:** If you're using Window's OS `chmod +x sort.sh` will not work
>
> Instead, use the following:
>
> - Open the locations of your `sort.sh` file
> - Right-click on the file
> - Select **Propertices**
> - Go to the **Security tab**
> - Here, you can manage file permissions for different users and groups by clicking **edit**

# How to run file in terminal

To run code within the terminal, `cd` into the folder where `orgainze.sh` is located and then run:

```bash
./orgainze.sh
```

# How to run file using alias

In the terminal run

```bash
alias organize = "./organize_file.sh"
```

In order for this to work properly make sure include paths of where `organize_file.sh` and add `./organize_file.sh` at the end of it

# How to run save alias using `~/.bashrc` file

Once your terminal is terminated you will no longer have access to the alias `organize` command
This is where `~/.bashrc` comes in. You will need to save the alias you wrote into the terminal.

You can do this by do this in your terminal:

```bash
vim ~/.bashrc
```

Then paste `alias organize = "./organize_file.sh"` into `~/.bashrc`. Once you have done that, you can now use your alias.
Well done!
