#!/bin/bash

# Run setup.
. ./setup.sh

# Duplicate the phpcs.xml boiler, and call it phpcs.xml.
cp phpcs-boiler.xml phpcs.xml

# Modify the phpcs.xml file in the pluginade module to contain the namespace and text domain of the plugin in question.
sed -i.bak "s/MadeWithPLUGINADE/$namespace/g" phpcs.xml
sed -i.bak "s/madewithpluginade/$textdomain/g" phpcs.xml

# Run the phpcs command from the wp-content directory.
if [ "$fix" = "1" ]; then
	./vendor/bin/phpcbf -q "$plugindir" --basepath=""
	./vendor/bin/phpcs -q "$plugindir";
else
	./vendor/bin/phpcs -q "$plugindir";
fi