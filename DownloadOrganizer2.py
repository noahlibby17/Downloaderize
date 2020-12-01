from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler

import os
import json
import time

class MyHandler(FileSystemEventHandler):
    def on_modified(self,event):
        for filename in os.listdir(folder_to_track):
            created_time = time.strftime('%d-%m-%Y',(time.localtime(os.path.getctime(folder_to_track + '/' + filename)))) # right now it's just getting the last modified date, not creation date because it doesn't work like that in Unix
            base, extension = os.path.splitext(filename)
            basename, split, fname = base.rpartition("/")
            if extension == ".twbx":
                src = folder_to_track + "/" + filename
                new_destination = tableau_folder_destination + "/" + str(fname) + "_" + created_time + extension
                os.rename(src, new_destination)
            elif extension == ".xlsx" or extension == ".csv":
                src = folder_to_track + "/" + filename
                new_destination = excel_folder_destination + "/" + str(fname) + "_" + created_time + extension
                os.rename(src, new_destination)
            elif extension == ".dmg":
                src = folder_to_track + "/" + filename
                new_destination = dmg_folder_destination + "/" + str(fname) + "_" + created_time + extension
                os.rename(src, new_destination)
            else:
                pass

folder_to_track = "/Users/noah.libby/Downloads"
tableau_folder_destination = "/Users/noah.libby/Documents/DownloadedFiles/Tableau"
excel_folder_destination = "/Users/noah.libby/Documents/DownloadedFiles/Excel"
dmg_folder_destination = "/Users/noah.libby/Documents/DownloadedFiles/DMGs"


event_handler = MyHandler()
observer = Observer()
observer.schedule(event_handler, folder_to_track, recursive=False)
observer.start()

try:
    while True:
        time.sleep(10)
except KeyboardInterrupt:
    observer.stop()
observer.join()
