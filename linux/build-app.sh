#!/bin/bash


# Build the Flutter app and package into an archive.


# Exit if any command fails
set -e

# Echo all commands for debug purposes
set -x


projectName=AdGuard-Home-Manager

archiveName=$projectName-Linux.tar.gz
baseDir=$(pwd)


# ----------------------------- Build Flutter app ---------------------------- #

flutter clean
flutter pub get
flutter build linux --release

flutter_to_debian

cd build/linux/x64/release/bundle || exit
mv "AdGuardHomeManager" "AdGuard Home Manager"
tar -czaf $archiveName ./*