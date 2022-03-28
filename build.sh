#!/bin/bash

# Loop through each wp-module in the plugin.

for DIR in wp-modules/*/; do
	# Go to the directory of this wp-module.
	cd "$DIR";
	echo "Module: $DIR"

	# Run the "npm run build" command in its package.json file.
	if [ -f package.json ]
	then
		npm run build
	fi

	# Go back to main directory, which includes the plugin modules.   
	cd -
	
done
