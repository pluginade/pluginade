#!/bin/bash

while getopts 'p:c:t:n:' flag; do
	case "${flag}" in
		p) PLUGIN_PATH=${OPTARG} ;;
		c) COMMAND=${OPTARG} ;;
		t) TEXTDOMAIN=${OPTARG} ;;
		n) NAMESPACE=${OPTARG} ;;
	esac
done

#  PHP Linting. 
if [ $COMMAND == 'lint:php' ]; then
	# Run PHP Code Sniffer with WordPress Coding Standards.
	cd docker;
	sh run.sh -p "${PLUGIN_PATH}" -c "sh phpcs.sh -t ${TEXTDOMAIN} -n ${NAMESPACE}" -n 0 -s 1;
fi

# PHP Lint Fixing.
if [ $COMMAND == 'lint:php:fix' ]; then
	# Run PHP Code Sniffer with WordPress Coding Standards.
	cd docker;
	sh run.sh -p "${PLUGIN_PATH}" -c "sh phpcs.sh -t ${TEXTDOMAIN} -n ${NAMESPACE} -f 1" -n 0 -s 1;
fi

# CSS Linting.
if [ $COMMAND == 'lint:css' ]; then
	cd docker;
	sh run.sh -p "${PLUGIN_PATH}" -c "sh lint-css.sh -t ${TEXTDOMAIN} -n ${NAMESPACE} -f 0" -n 0 -s 1;
fi

# CSS Lint Fixing.
if [ $COMMAND == 'lint:css:fix' ]; then
	cd docker;
	sh run.sh -p "${PLUGIN_PATH}" -c "sh lint-css.sh -t ${TEXTDOMAIN} -n ${NAMESPACE} -f 1" -n 0 -s 1;
fi

# PHP Unit Testing. To run this, type: sh pluginade.sh test:phpunit
if [ $COMMAND == 'test:phpunit' ]; then
	# Run PHP Unit Tests.
	cd docker-phpunit;
	sh run.sh -p "${PLUGIN_PATH}" -c "sh phpunit.sh -t ${TEXTDOMAIN} -n ${NAMESPACE}" -n 0 -s 1;
fi
