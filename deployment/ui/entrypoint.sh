#!/bin/bash
set -e

echo "Building rue-ui with environment variables..."
echo "VITE_API_URL: ${VITE_API_URL}"
echo "VITE_MAPBOX_TOKEN: ${VITE_MAPBOX_TOKEN:0:10}..." # Only show first 10 chars of token

# Build the application using environment variables
cd /app
npm run build

# Deploy build to nginx
echo "Deploying to nginx..."
rm -rf /usr/share/nginx/html/*
cp -r dist/* /usr/share/nginx/html/

echo "Starting nginx..."
exec nginx -g "daemon off;"
