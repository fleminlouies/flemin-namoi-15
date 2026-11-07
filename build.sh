#!/bin/sh
set -eu
mkdir -p public
cp index.html sender.html style.css script.js maps-qr.png og-image.jpg wedding-cover.jpg wedding.ics public/
HOST="${VERCEL_PROJECT_PRODUCTION_URL:-${VERCEL_URL:-}}"
if [ -n "$HOST" ]; then
  sed -i "s|content=\"/og-image.jpg\"|content=\"https://$HOST/og-image.jpg\"|g" public/index.html
fi
