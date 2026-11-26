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

# Store floral art in deployed output; leave site functional if source expires.
curl --fail --location --silent --show-error --max-time 45 'https://dnznrvs05pmza.cloudfront.net/seedream_5_pro/c99219a7-4998-4828-a4d3-998c2c36b452/Photorealistic_botanical_cutout_of_a_long_slender_natural_brown_plum_blossom_branch__rich_dark_crims_0.png?_jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJrZXlIYXNoIjoiOTllNTE1N2Q2ZjY1NjQ3NSIsImJ1Y2tldCI6InJ1bndheS10YXNrLWFydGlmYWN0cyIsInN0YWdlIjoicHJvZCIsImV4cCI6MTc5NTc3MzY5M30.hm7XNosZPzStoZKE6yDTYBnk20v2EmIRbxdnlnT-TYA' -o public/v9-blossom.png || { rm -f public/v9-blossom.png; echo 'Floral asset unavailable'; }
