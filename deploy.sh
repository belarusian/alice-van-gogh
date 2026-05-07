#!/bin/bash

# Deploy van-gogh presentation to S3
# Usage: ./deploy.sh

set -e

BUCKET="aliceart.gallery"
REMOTE="origin"
BRANCH="main"

echo "🎨 Deploying Van Gogh presentation to S3..."

# Pull latest changes
echo "📦 Pulling latest from $REMOTE/$BRANCH..."
git pull $REMOTE $BRANCH

# Sync to S3 (exclude git files and configs)
echo "☁️  Syncing to S3 bucket: $BUCKET..."
aws s3 sync . "s3://$BUCKET/" \
  --exclude ".git/*" \
  --exclude ".gitignore" \
  --exclude "deploy.sh" \
  --exclude "website-config.json" \
  --delete

echo "✅ Deployed! Your presentation is live at:"
echo "   https://$BUCKET"
