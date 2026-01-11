#!/bin/bash
# deploy.sh - Automated APK download and deployment script
# Usage: ./deploy.sh

set -e

cd "$(dirname "$0")"

# Get repository name
REPO=$(gh repo view --json nameWithOwner -q .nameWithOwner 2>/dev/null || echo "unknown")
APP_NAME=$(basename "$REPO")

echo "📦 Checking latest build for $REPO..."

# Get latest successful run
RUN_ID=$(gh run list --limit 1 --json databaseId,status -q '.[] | select(.status=="completed") | .databaseId')

if [ -z "$RUN_ID" ]; then
    echo "❌ No completed builds found. Push changes to trigger a build."
    exit 1
fi

echo "✓ Found run ID: $RUN_ID"
echo "📥 Downloading APK..."

# Clean up old APK
rm -f app-debug.apk

# Download artifact
if ! gh run download "$RUN_ID" --name app-debug 2>/dev/null; then
    echo "❌ Failed to download APK. Build may still be running."
    echo "Check status: gh run view $RUN_ID"
    exit 1
fi

# Deploy to Downloads
DEST_PATH="/storage/emulated/0/Download/${APP_NAME}.apk"
cp app-debug.apk "$DEST_PATH"

# Get APK size
APK_SIZE=$(du -h app-debug.apk | cut -f1)

echo "✓ Deployed successfully!"
echo "📱 Location: $DEST_PATH"
echo "📊 Size: $APK_SIZE"
echo ""
echo "Install with: termux-open $DEST_PATH"
