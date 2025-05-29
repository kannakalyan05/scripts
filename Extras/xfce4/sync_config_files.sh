#!/bin/bash

# Path to the source config folder (relative or absolute)
SOURCE_DIR="./config"
TARGET_DIR="$HOME/.config"

# Check if SOURCE_DIR exists
if [ ! -d "$SOURCE_DIR" ]; then
  echo "Source directory '$SOURCE_DIR' does not exist."
  exit 1
fi

# Loop over each folder in the source config directory
for folder in "$SOURCE_DIR"/*; do
  if [ -d "$folder" ]; then
    folder_name=$(basename "$folder")

    # If the same folder exists in ~/.config, delete it
    if [ -d "$TARGET_DIR/$folder_name" ]; then
      echo "Removing existing $TARGET_DIR/$folder_name"
      rm -rf "$TARGET_DIR/$folder_name"
    fi

    # Copy the folder to ~/.config
    echo "Copying $folder_name to $TARGET_DIR"
    cp -r "$folder" "$TARGET_DIR/"
  fi
done

echo "Sync complete."
