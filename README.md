# NOTE: This project has been replace by Pluginade Scripts
This project has been moved and replaced by [pluginade-scripts](https://github.com/pluginade/pluginade-scripts)

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

Lastly, make sure to ignore the pluginade directory so you dont commit it to your git repo by adding a line to your .gitignore file like this:

```
/pluginade
```

That's it!
