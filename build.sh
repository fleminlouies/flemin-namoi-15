#!/bin/sh
set -eu
mkdir -p public
cp index.html sender.html personal-cover.webp style.css script.js maps-qr.png og-image.jpg wedding-cover.jpg wedding.ics public/
HOST="${VERCEL_PROJECT_PRODUCTION_URL:-${VERCEL_URL:-}}"
if [ -n "$HOST" ]; then
  sed -i "s|content=\"/og-image.jpg\"|content=\"https://$HOST/og-image.jpg\"|g" public/index.html
fi

# Keep the normal invitation's existing social preview unchanged.
# A separate HTML copy supplies distinct metadata for personalized guest links.
cp public/index.html public/personal.html
sed -i 's#Flemin \&amp; Naomi | Wedding Invitation 🤍#Flemin \&amp; Naomi — A Personal Invitation#g' public/personal.html
sed -i 's|content="Friday, 15 January 2027"|content="A special wedding invitation, just for you · 15 January 2027"|g' public/personal.html
sed -i 's|content="https://flemin-naomi.vercel.app/wedding-cover.jpg"|content="https://flemin-naomi.vercel.app/personal-cover.webp"|g' public/personal.html
sed -i 's|content="image/jpeg"|content="image/webp"|g' public/personal.html
