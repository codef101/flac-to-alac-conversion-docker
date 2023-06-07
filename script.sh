#!/bin/sh

input_dir="/app/input"
output_dir="/app/output"

convert_flac_to_alac() {
  local dir="$1"
  local top_dir="$2"

  for item in "$dir"/*; do

    if [ -f "$item" ] && [ "${item##*.}" = "flac" ]; then

      local filename=$(basename "$item" .flac)
      ffmpeg -i "$item" -c:a alac "$output_dir/$filename.m4a"

      rm "$item"
      echo "Converted $item"

    elif [ -d "$item" ]; then

      convert_flac_to_alac "$item" "$top_dir"
      if [ -z "$(ls -A "$item")" ]; then
        directory="$(echo "$item" | sed 's|/\*$||')"
        rm -rf "$directory"
        echo "Deleted empty directory: $directory"

        if [ "$item" != "$top_dir" ]; then
          echo "Changing to parent dir"
          cd ..
        fi
      fi

    fi
  done
}

while true; do
  convert_flac_to_alac "$input_dir" "$input_dir"
  sleep 1
done
