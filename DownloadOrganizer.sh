#!/bin/bash

user='noah.libby'

# get current datetime
now=$(date)
now_full=$(date +'%Y-%m-%d')
my_foldername="$(date +'%b_%Y')_Downloads/"

echo $now_full
echo $my_foldername

cd /Users/${user}/Downloads/

# check to see if there is a folder for this mon_year_downloads
path="/Users/${user}/Downloads/${my_foldername}"
echo $path
if [ -d "$path" ]; then
    echo "$path exists."
else
    echo "$path does not exist."
    mkdir $path
fi

# iterate through downloads folder
for f in *; do

    if [[ -d "$f" ]]; then
        # Will not run if no directories are available
        echo "$f"
        # if directory name like mon_year_downloads then continue
        if [[ "$f" =~ [A-Z][a-z][a-z]_[0-9][0-9][0-9][0-9]_Downloads ]]; then
            echo 'Subdirectory.'
        # if other dir, move to proper subdir
        else mv $f "${path}${f}"
        fi

    else     # if file, mv to proper downloads folder and rename
        base=${f%%.*}
        ext=${f#*.}
        echo "${path}${base}_${now_full}.${ext}"
        mv "./$f" "${path}${base}_${now_full}.${ext}"

    fi
done
