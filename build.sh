#!/bin/sh
set -eu
mkdir -p public
cp index.html v3.html sender.html personal-cover.webp style.css script.js maps-qr.png og-image.jpg wedding-cover.jpg wedding.ics public/
HOST="${VERCEL_PROJECT_PRODUCTION_URL:-${VERCEL_URL:-}}"
if [ -n "$HOST" ]; then
  sed -i "s|content=\"/og-image.jpg\"|content=\"https://$HOST/og-image.jpg\"|g" public/index.html
fi

# Keep the normal invitation's existing social preview unchanged.
# A separate HTML copy supplies distinct metadata for personalized guest links.
cp public/index.html public/personal.html
sed -i 's|content="https://flemin-naomi.vercel.app/wedding-cover.jpg"|content="https://flemin-naomi.vercel.app/personal-cover.webp"|g' public/personal.html
sed -i 's|content="image/jpeg"|content="image/webp"|g' public/personal.html

cp v4.html public/v4.html

cp v5.html public/v5.html

cp v6.html public/v6.html

cp v7.html public/v7.html

cp v8.html public/v8.html

cp v9.html public/v9.html
npm install --prefix /tmp/v9-image-tools --no-audit --no-fund sharp@0.34.5
NODE_PATH=/tmp/v9-image-tools/node_modules node optimize-v9.cjs

cp thumbnail-1.jpg public/v9-og-1.jpg
OG_HOST="${VERCEL_URL:-${VERCEL_PROJECT_PRODUCTION_URL:-flemin-naomi.vercel.app}}"
sed -i "s|__V9_OG_HOST__|$OG_HOST|g" public/v9.html
