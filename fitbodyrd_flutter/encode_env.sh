#!/bin/bash

# Script to generate base64 encoded .env file for GitHub Secrets
# Usage: ./encode_env.sh

ENV_FILE=".env"

# Check if .env file exists
if [ ! -f "$ENV_FILE" ]; then
  echo "Error: $ENV_FILE does not exist in the current directory!"
  echo "Please create a .env file first."
  exit 1
fi

# Generate base64 encoded string
echo "Encoding $ENV_FILE to base64..."
BASE64_STRING=$(base64 -i "$ENV_FILE")

echo ""
echo "=========================================="
echo "Base64 Encoded .env File"
echo "=========================================="
echo "$BASE64_STRING"
echo "=========================================="
echo ""
echo "Next steps:"
echo "1. Go to your GitHub repository"
echo "2. Navigate to Settings > Secrets and variables > Actions"
echo "3. Click 'New repository secret'"
echo "4. Name: ENV_FILE_BASE64"
echo "5. Value: Paste the base64 string above"
echo "6. Click 'Add secret'"
echo ""
