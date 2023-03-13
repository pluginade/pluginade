#!/bin/bash

# Run setup.
. ./setup.sh

plugin_slug="$(basename "$plugindir")"

build_version=`grep 'Version:' "$plugindir"/$plugin_slug.php | cut -f4 -d' '`
zip_file_name="$plugin_slug.$build_version.zip"
cd "$(dirname "$plugindir")"

if [ -f "$plugindir/.zipignore" ]; then
	ignore_file="$plugindir/.zipignore"
else if [ -f "$plugindir/.distignore" ]; then
	ignore_file="$plugindir/.distignore"
else
	echo "Error: please add a .zipignore to the root of the plugin"
	exit 1
fi

zip -r "$zip_file_name" "$plugin_slug" -x@"$ignore_file"
mv "$zip_file_name" "$plugindir"