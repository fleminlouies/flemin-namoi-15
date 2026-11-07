# Flemin & Naomi — Wedding website

A lightweight responsive single-page wedding website with a custom WhatsApp/social thumbnail, working venue QR code, Google Maps directions, countdown, and downloadable calendar event.

## Deploy on Vercel
1. Extract the ZIP and upload the `flemin-naomi-wedding` folder to a new GitHub repository.
2. In Vercel select **Add New → Project**, import the repository, and deploy. Framework preset: **Other**.
3. Vercel runs `sh build.sh` and publishes the `public` folder. The build inserts the production deployment hostname into the Open Graph image URL for WhatsApp previews.
4. Open the live URL on mobile and test Google Maps, QR and calendar. Share the live URL on WhatsApp to check the preview. WhatsApp previews can be cached.

No RSVP system is included. The image at `og-image.jpg` is the dedicated 1200×630 WhatsApp thumbnail. The QR points directly to the Google Maps URL, not the website. If the wedding site gets a custom domain, redeploy so the thumbnail URL uses that domain.

The venue name/address are based on the previously discussed details and should be checked before sharing publicly.
