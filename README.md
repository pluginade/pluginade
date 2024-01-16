# Pluginade

Run phpunit, eslint, and stylelint using WordPress Coding Standards for any WordPress plugin by setting up your package.json file like this:

## Your package.json file in your plugin.
```
{
	"name": "your-plugin-name",
	"version": "1.0.0",
	"license": "GPL-2.0",
	"repository": {
		"type": "git",
		"url": "your-repo-url-here"
	},
	"pluginade_options": "-n YourPluginNamespace -t your-plugin-textdomain",
	"scripts": {
		"preinstall": "if [ ! -d ../../pluginade ]; then git clone https://github.com/pluginade/pluginade ../../pluginade; else cd ../../pluginade && git reset --hard && git checkout main && git pull origin main;fi;",
		"postinstall": "cd ../../pluginade; sh install.sh $npm_package_pluginade_options -p \"${OLDPWD}\";",
		"reinstall": "cd ../../pluginade; sh install-clean.sh $npm_package_pluginade_options -p \"${OLDPWD}\";",
		"dev": "cd ../../pluginade; sh dev.sh $npm_package_pluginade_options -p \"${OLDPWD}\";",
		"dev-env": "cd ../../pluginade; sh dev-env.sh $npm_package_pluginade_options -p \"${OLDPWD}\";",
		"build": "cd ../../pluginade; sh build.sh $npm_package_pluginade_options -p \"${OLDPWD}\";",
		"test:phpunit": "cd ../../pluginade; sh phpunit.sh $npm_package_pluginade_options -p \"${OLDPWD}\";",
		"lint:php": "cd ../../pluginade; sh phpcs.sh $npm_package_pluginade_options -p ${OLDPWD};",
		"lint:php:fix": "cd ../../pluginade; sh phpcs.sh $npm_package_pluginade_options -p \"${OLDPWD}\" -f 1;",
		"lint:js": "cd ../../pluginade; sh lint-js.sh $npm_package_pluginade_options -p \"${OLDPWD}\"",
		"lint:js:fix": "cd ../../pluginade; sh lint-js.sh $npm_package_pluginade_options -p \"${OLDPWD}\" -f 1;",
		"lint:css": "cd ../../pluginade; sh lint-css.sh $npm_package_pluginade_options -p \"${OLDPWD}\";",
		"lint:css:fix": "cd ../../pluginade; sh lint-css.sh $npm_package_pluginade_options -p \"${OLDPWD}\" -f 1;",
		"test:js": "cd ../../pluginade; sh test-js.sh $npm_package_pluginade_options -p \"${OLDPWD}\";",
		"zip": "cd ../../pluginade; sh zip.sh $npm_package_pluginade_options -p \"${OLDPWD}\";"
	}
}
```

In the example package.json file above, simply replace these strings:

- `your-plugin-name` - A slug for your plugin
- `YourPluginNamespace` - The unique namespace used for your plugin (Will be enforced as function/class prefix in WordPress Coding Standards)
- `your-plugin-textdomain` - The text domain to use for your plugin (Will be enforced by WordPress Coding Standards)

Then inside your plugin, run `npm run install`. This will clone this repo inside your plugin's directory, and make the commands like `npm run lint:php` work on the command line when inside the plugin's directory.

That's it!

## Docker Mode
You can also run pluginade in docker mode to test/lint any plugin, anytime. To do so, follow these steps:

1. Make sure you have Docker Desktop installed and running. It's free and easy to install.
2. Clone this repo somewhere on your hardrive.
3. On the command line, go to this repo's directory like this `cd /the/path/to/where/you/cloned/this/repo`
5. Build the docker image by running this `sh build.sh`
6. You can now run commands to run pluginade functions inside docker containers. For example:

### Running WPCS linting for your plugin inside a docker container:
Run `cd ./docker; sh run.sh -p "/path/to/plugin" -c "sh phpcs.sh -t your-plugin-textdomain -n YourPluginNamespace" -n 0 -w "/usr/src/pluginade/pluginade-scripts/" -s 1; cd ../;`

### Running PHP Unit testing for your plugin inside a docker container:
Run `cd ./docker-phpunit; sh run.sh -p "/path/to/plugin" -c "sh phpunit.sh -t your-plugin-textdomain -n YourPluginNamespace" -n 0 -w "/usr/src/pluginade/pluginade-scripts/" -s 1; cd ../`

### Running CSS linting for your plugin inside a docker container:
Run `sh run.sh -p "/path/to/plugin" -c "sh lint-css.sh -t your-plugin-textdomain -n YourPluginNamespace" -n 0 -w "/usr/src/pluginade/pluginade-scripts/" -s 1`

### Running Javascript linting for your plugin inside a docker container:
Run `sh run.sh -p "/path/to/plugin" -c "sh lint-js.sh -t your-plugin-textdomain -n YourPluginNamespace" -n 0 -w "/usr/src/pluginade/pluginade-scripts/" -s 1`

### Running Javascript testing for your plugin inside a docker container:
Run `sh run.sh -p "/path/to/plugin" -c "sh test-js.sh -t your-plugin-textdomain -n YourPluginNamespace" -n 0 -w "/usr/src/pluginade/pluginade-scripts/" -s 1`

### Notes:
While running these commands manually might be cumbersome, they can be useful for automations. For example, the Pluginade Desktop App uses these docker containers, tied to a UI.