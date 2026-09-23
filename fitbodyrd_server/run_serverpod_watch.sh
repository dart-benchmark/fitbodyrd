#!/bin/bash

# Automatically restart serverpod generate --watch if it crashes

# Trap Ctrl+C (SIGINT) so you can exit cleanly
trap "echo 'Stopping serverpod watcher...'; exit 0" SIGINT

while true; do
  echo "Starting serverpod generate --watch..."
  serverpod generate --watch

  exit_code=$?
  echo "serverpod exited with code $exit_code"

  # Exit cleanly if the user stopped it with Ctrl+C (exit code 130)
  if [ $exit_code -eq 130 ]; then
    echo "Interrupted by user."
    exit 0
  fi

  echo "Restarting in 1 seconds..."
  sleep 1
done
