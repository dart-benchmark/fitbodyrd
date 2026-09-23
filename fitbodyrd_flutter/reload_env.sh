#!/bin/bash

ENV_FILE=".env"

# Check if the environment file exists
if [ ! -f "$ENV_FILE" ]; then
  echo "Error: $ENV_FILE does not exist!"
  exit 1
fi

# Run build_runner
flutter pub run build_runner clean
flutter pub run build_runner build --delete-conflicting-outputs

echo "Build complete!"
