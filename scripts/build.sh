#!/bin/sh
# Prépare dist/ (et une archive .zip) pour together.army.
# Usage : ./scripts/build.sh [netlify|vercel|ovh]   (netlify par défaut)
set -e
TARGET="${1:-netlify}"
cd "$(dirname "$0")/.."
rm -rf dist together-army-site.zip
mkdir dist
cp -R index.html 404.html robots.txt sitemap.xml site.webmanifest favicon.ico favicon-32.png apple-touch-icon.png assets dist/
case "$TARGET" in
  netlify) cp _redirects _headers dist/ ;;
  vercel)  cp vercel.json dist/ ;;
  ovh)     cp .htaccess dist/ ;;
  *) echo "Cible inconnue : $TARGET (netlify|vercel|ovh)"; exit 1 ;;
esac
find dist -name .DS_Store -delete
(cd dist && zip -qr ../together-army-site.zip . -x '*.DS_Store')
echo "OK ($TARGET) : dist/ et together-army-site.zip prêts ($(du -sh dist | cut -f1))"
