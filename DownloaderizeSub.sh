#!/bin/bash

user='noah.libby'

# get current datetime
now=$(date)
now_full=$(date +'%Y-%m-%d')
my_foldername="$(date +'%b_%Y')_Downloads/"

#echo $now_full
#echo $my_foldername

cd /Users/${user}/Downloads/

# check to see if there is a folder for this mon_year_downloads
path="/Users/${user}/Downloads/${my_foldername}"
echo $path
if [ -d "$path" ]; then
    echo "$path exists."
else
    echo "$path does not exist."
    mkdir $path
    mkdir -p ${path}{images,tableau,spreadsheets,docs,scripts,etc/dmg}
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

        if [ .$ext = '.jpg' ] || [ .$ext = '.png' ] || [ .$ext = '.tiff' ] || [ .$ext = '.gif' ]; then
          mv "./$f" "${path}images/${base}_${now_full}.${ext}"
        elif [ .$ext = '.twbx' ] || [ .$ext = '.twb' ]; then
          mv "./$f" "${path}tableau/${base}_${now_full}.${ext}"
        elif [ .$ext = '.xls' ] || [ .$ext = '.xlsx' ] || [ .$ext = '.csv' ]; then
          mv "./$f" "${path}spreadsheets/${base}_${now_full}.${ext}"
        elif [ .$ext = '.sql' ] || [ .$ext = '.sh' ] || [ .$ext = '.py' ]; then
          mv "./$f" "${path}scripts/${base}_${now_full}.${ext}"
        elif [ .$ext = '.doc' ] || [ .$ext = '.docx' ] || [ .$ext = '.pages' ] || [ .$ext = '.txt' ] || [ .$ext = '.pdf' ] || [ .$ext = '.rtf' ]; then
          mv "./$f" "${path}docs/${base}_${now_full}.${ext}"
        elif [ .$ext = '.dmg' ]; then
          mv "./$f" "${path}etc/dmg/${base}_${now_full}.${ext}"
        else mv "./$f" "${path}etc/${base}_${now_full}.${ext}"
        fi

    fi
done
