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

cp v9.html v9.css v9.js public/
npm install --prefix /tmp/v9-image-tools --no-audit --no-fund sharp@0.34.5 qrcode@1.5.4 esbuild@0.25.12
/tmp/v9-image-tools/node_modules/.bin/esbuild v9.css --minify --outfile=public/v9-final-3.css
/tmp/v9-image-tools/node_modules/.bin/esbuild v9.js --minify --outfile=public/v9-final-2.js
NODE_PATH=/tmp/v9-image-tools/node_modules node optimize-v9.cjs

NODE_PATH=/tmp/v9-image-tools/node_modules node -e "const s=require('sharp');(async()=>{for(const quality of [90,85,80,75,70,60]){const out=await s('A2DF40A1-66C6-4B6F-9C28-D4AA39973332.png').resize(1200,675,{fit:'fill'}).jpeg({quality,mozjpeg:true}).toBuffer();if(out.length<=200000||quality===60){require('fs').writeFileSync('public/v9-og-2.jpg',out);console.log('OG bytes',out.length);break;}}})().catch(e=>{console.error(e);process.exit(1)})"
OG_HOST="flemin-naomi.vercel.app"
sed -i "s|__V9_OG_HOST__|$OG_HOST|g" public/v9.html

# Enable V9 audio only when the licensed recording is supplied.
if [ -f "When God Made You (Wedding Version) Piano Cover by James Wong - James Wong (64k).mp3" ]; then
  cp "When God Made You (Wedding Version) Piano Cover by James Wong - James Wong (64k).mp3" public/v9-music-1.mp3
  sed -i 's|<head>|<head><script>window.V9_MUSIC_AVAILABLE=true;</script>|' public/v9.html
fi

NODE_PATH=/tmp/v9-image-tools/node_modules node -e "require('qrcode').toFile('public/v9-map-qr-1.png','https://www.google.com/maps/dir/?api=1&destination=The%20Green%20Acres%2C%20Behind%20Racecourse%2C%20Chamundipuram%2C%20Mysuru',{width:300,margin:2}).catch(e=>{console.error(e);process.exit(1)})"
# Publish V9 at the root only for production builds; preserve previous invitation.
if [ "${VERCEL_ENV:-}" = production ]; then
  cp public/index.html public/legacy.html
  cp public/v9.html public/index.html
fi

cp v11.html public/
/tmp/v9-image-tools/node_modules/.bin/esbuild v11.css --minify --outfile=public/v11-final-5.css
sed -i "s|__V9_OG_HOST__|$OG_HOST|g" public/v11.html
if [ -f public/v9-music-1.mp3 ]; then sed -i 's|<head>|<head><script>window.V9_MUSIC_AVAILABLE=true;</script>|' public/v11.html; fi
