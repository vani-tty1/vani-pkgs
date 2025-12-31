#!/bin/bash
# Usage: ./add-deb.sh path/to/new_package.deb

GPG_EMAIL="giovannirafanan609@gmail.com"


if [ ! -z "$1" ]; then
    cp "$1" deb/
    echo " Copied $1 to deb/ folder"
fi


echo "Regenerating Packages and Release files..."
cd deb
dpkg-scanpackages --multiversion . > Packages
gzip -k -f Packages
apt-ftparchive release . > Release


echo "Signing Release..."
rm -f Release.gpg InRelease
gpg --default-key "$GPG_EMAIL" -abs -o - Release > Release.gpg
gpg --default-key "$GPG_EMAIL" --clearsign -o - Release > InRelease
cd ..


echo "Updating HTML Index..."
./gen-index.sh


echo "Pushing to GitHub..."
git add deb/Packages* deb/Release* deb/InRelease deb/*.deb *.html
git commit -m "Repo update: Added new package"
git push

echo "Done!"
