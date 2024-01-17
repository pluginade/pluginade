# Pluginade Scripts
Pluginade Scripts is a simple solution for adding linting, testing, zipping, and more to your WordPress plugin in seconds.

It allows you to instantly run PHP WordPress Coding Standards, phpunit, eslint, stylelint and more, on any machine that supports Docker.

# Getting Started

## Create and commit this file to your WordPress plugin's root directory, and call it pluginade.sh
```
#!/bin/bash

# Change the following variables to your plugin's namespace and textdomain:
textdomain="my-plugin-text-domain";
namespace="MyPluginNamespace";

# Dont make any more edits below this line.

# Check if an argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <The pluginade command you want to run>"
    exit 1
fi

#  Set the plugin directory to be the current directory.
plugindir=$(pwd);

#  Install pluginade-scripts if they are not already installed.
if [ ! -d ./pluginade ]; then git clone https://github.com/pluginade/pluginade ./.pluginade; cd .pluginade && git reset --hard && git checkout docker && git pull origin docker; fi;

#  Start dev mode (npm run dev) for all wp-modules.
if [ $1 == 'dev' ]; then
	# Run PHP Code Sniffer with WordPress Coding Standards.
	sh pluginade-run.sh -p "${plugindir}" -c "dev" -t $textdomain -n $namespace;
fi

#  Run build (npm run build) for all wp-modules.
if [ $1 == 'build' ]; then
	# Run PHP Code Sniffer with WordPress Coding Standards.
	sh pluginade-run.sh -p "${plugindir}" -c "build" -t $textdomain -n $namespace;
fi

#  PHP Linting. To run this, type: sh pluginade.sh lint:php
if [ $1 == 'lint:php' ]; then
	# Run PHP Code Sniffer with WordPress Coding Standards.
	sh pluginade-run.sh -p "${plugindir}" -c "lint:php" -t $textdomain -n $namespace;
fi

# PHP Lint Fixing. To run this, type: sh pluginade.sh lint:php:fix
if [ $1 == 'lint:php:fix' ]; then
	sh pluginade-run.sh -p "${plugindir}" -c "lint:php:fix" -t $textdomain -n $namespace;
fi

#  CSS Linting. To run this, type: sh pluginade.sh lint:css
if [ $1 == 'lint:css' ]; then
	# Run CSS linting.
	sh pluginade-run.sh -p "${plugindir}" -c "lint:css" -t $textdomain -n $namespace;
fi

# CSS Lint Fixing. To run this, type: sh pluginade.sh lint:css:fix
if [ $1 == 'lint:css:fix' ]; then
	# Run CSS linting.
	sh pluginade-run.sh -p "${plugindir}" -c "lint:css:fix" -t $textdomain -n $namespace;
fi

#  JS Linting. To run this, type: sh pluginade.sh lint:js
if [ $1 == 'lint:js' ]; then
	sh pluginade-run.sh -p "${plugindir}" -c "lint:js" -t $textdomain -n $namespace;
fi

# JS Lint Fixing. To run this, type: sh pluginade.sh lint:js:fix
if [ $1 == 'lint:js:fix' ]; then
	sh pluginade-run.sh -p "${plugindir}" -c "lint:js:fix" -t $textdomain -n $namespace;
fi

# JS Jest Testing. To run this, type: sh pluginade.sh test:js
if [ $1 == 'test:js' ]; then
	sh pluginade-run.sh -p "${plugindir}" -c "test:js" -t $textdomain -n $namespace;
fi

# PHP Unit Testing. To run this, type: sh pluginade.sh test:phpunit
if [ $1 == 'test:phpunit' ]; then
	sh pluginade-run.sh -p "${plugindir}" -c "test:phpunit" -t $textdomain -n $namespace;
fi

# Build an installable zip. To run this, type: sh pluginade.sh zip
if [ $1 == 'zip' ]; then
	sh pluginade-run.sh -p "${plugindir}" -c "zip" -t $textdomain -n $namespace;
fi
```

In the file above, simply replace these strings:

- `my-plugin-text-domain` - The text domain to use for your plugin (Will be enforced by WordPress Coding Standards)
- `MyPluginNamespace` - The unique namespace used for your plugin (Will be enforced as function/class prefix in WordPress Coding Standards)

Then, on the command line inside your plugin, run one of the following commands:

### To lint your plugin's PHP code using WordPress Coding Standards, run this command:
`sh pluginade.sh lint:php`

If you want to override any WordPress Coding Standards for your project, add your own custom phpcs.xml file to the root of your plugin, and Pluginade will use that.

### To automatically fix any PHP issues that can be autofixed to conform with WordPress Coding Standards, run this command:
`sh pluginade.sh lint:php:fix`

### To lint your plugin's CSS code using WordPress's standards, run this command:
`sh pluginade.sh lint:css`

### To automatically fix any CSS issues that can be autofixed to conform with WordPress's standards, run this command:
`sh pluginade.sh lint:css:fix`

### To lint your plugin's Javascript code using WordPress's standards, run this command:
`sh pluginade.sh lint:js`

If you want to override any javascript standards in your own plugin, ass your own `.eslintrc` file to the root of your plugin, and Pluginade will use that.

### To automatically fix any Javascript issues that can be autofixed to conform with WordPress's standards, run this command:
`sh pluginade.sh lint:js:fix`

### To run PHPUnit on your plugin's code, run this command:
`sh pluginade.sh test:phpunit`

### To run Jest tests on your plugin's Javascript code, run this command:
`sh pluginade.sh test:js`

### To build your plugin with webpack, run this command:
`sh pluginade.sh build`

### To put your plugin into webpack development mode, run this command:
`sh pluginade.sh dev`

### To create a zip of your plugin, run this command
`sh pluginade.sh zip`

Note that you can add a .zipignore file to the root of your plugin to control what files are not included in the zip. Pluginade includes a default zipignore which removes things usually not desired (like node_modules directories), but this can be overridden.