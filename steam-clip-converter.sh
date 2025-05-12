#!/bin/bash
mkdir -p ~/Videos

folder=$(pwd)
echo "Working directory: $folder"

for i in $(ls clips); do
  video_path=./clips/$i/video
  subdirs=($(find "$video_path" -mindepth 1 -maxdepth 1 -type d))
  count=${#subdirs[@]}

  idx=1

  for subdir in ${subdirs[*]}; do
    # You may change "output_file=~/Videos/$i.mkv" and "output_file=~/Videos/${i}_$idx.mkv"
    #             to "output_file=~/Videos/$i.mp4" and "output_file=~/Videos/${i}_$idx.mp4".
    if [ $count -eq 1 ]; then
      output_file=~/Videos/$i.mkv
    else
      output_file=~/Videos/${i}_$idx.mkv
    fi

    if [ -f "$output_file" ]; then
      echo "File $output_file already exists. Skipping..."
      idx=$((idx + 1))
      continue
    fi

    echo "Processing clip: $i (segment $idx of $count)"
    cd $subdir
    pwd

    tmp_vid=/tmp/video_${i}_$idx.mp4
    tmp_aud=/tmp/audio_${i}_$idx.mp4

    cat ./init-stream0.m4s ./chunk-stream0-*.m4s > $tmp_vid
    cat ./init-stream1.m4s ./chunk-stream1-*.m4s > $tmp_aud

    ffmpeg -i $tmp_vid -i $tmp_aud -c copy $output_file

    rm $tmp_vid $tmp_aud

    cd $folder
    idx=$((idx + 1))
  done
done

