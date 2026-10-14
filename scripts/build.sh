#!/bin/sh
# Prépare le dossier dist/ (et une archive .zip) à mettre en ligne sur together.army.
set -e
cd "$(dirname "$0")/.."
rm -rf dist together-army-site.zip
mkdir dist
cp -R index.html 404.html robots.txt sitemap.xml site.webmanifest favicon.ico favicon-32.png apple-touch-icon.png .htaccess vercel.json assets dist/
find dist -name .DS_Store -delete
(cd dist && zip -qr ../together-army-site.zip . -x '*.DS_Store')
echo "OK : dist/ et together-army-site.zip prêts ($(du -sh dist | cut -f1))"
