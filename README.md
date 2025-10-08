# steamdeck-recording-to-mp4
## A short script to create single .mp4 file from recordings made by Steam Deck
A simple script which merges audio and video fragments into single .mp4 or .mkv file. 
ffmpeg is required.

# How to use?
Find *clips* folder (Steam -> Settings -> Game Recording -> Raw recordings folder) on your Steam Deck or copy it to any PC with Linux. 

You have to be in a folder with *video* folder, not in that folder.

Run script - copy it's content to a file called script.name.sh, then do ```chmod +x ./script.name.sh``` to make it executable. After that, run ```./path/to/script.name.sh``` after that.

```
#!/bin/bash
folder=$(pwd)
echo $folder
for i in $(ls video);
do
  cd ./video/$i/
  cd ./$(ls);
  pwd;
  sleep 10s;
  cat ./init-stream0.m4s ./chunk-stream0-*.m4s > ./video_$i.mp4;
  cat ./init-stream1.m4s ./chunk-stream1-*.m4s > ./audio_$i.mp4;
  sleep 10s;
#You may change "copy ~/$i.mkv" to "copy /path/to/script/output/$i.mkv" or change "$i.mkv" to "$i.mp4".
#If file already exists, you will be asked to overwrite it.
  ffmpeg -i ./video_$i.mp4 -i ./audio_$i.mp4 -c copy ~/$i.mkv;
  cd $folder;
done
```
After that, you will have videos in your home folder.
