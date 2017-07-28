#!/bin/bash

# SQWEB - PHP SDK LEGACY - RELEASE BUILDER
# ------------------------------------------------------------------------------
# This script simply zips all the required files for distribution.

BUILD=build/sqweb-sdk-php-legacy

# Create destination folder
mkdir -p $BUILD

# Copy source files
cp -R src/ $BUILD/src/

# Copy Documentation
cp README.md CHANGELOG.md $BUILD

echo "Zipping the build..."
pushd build; zip -r -X sqweb-sdk-php-legacy.zip sqweb-sdk-php-legacy; popd

echo "Cleaning up the build files..."
rm -rf $BUILD/*
rmdir $BUILD
echo "Done."