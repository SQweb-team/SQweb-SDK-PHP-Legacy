# SQweb - PHP SDK - Legacy Version

## Disclaimer

:warning:

**You should absolutely not be running PHP v5.2.x today, since it's an unsupported version of the language, without updates and security patches since Jan 2011.** For more information about End Of Life PHP branches, [see this page](http://php.net/supported-versions.php).

**This Legacy SDK is provided as a convenience, and support may be provided on a best-effort basis only.**

We strongly advise you to update to a newer and supported version of PHP, such as v5.6. If you are on a shared hosting plan, please ask your provider for help and instructions.

This SDK has been tested with PHP 5.2.17 only.

## Install

**This package is intended for custom PHP websites and advanced integrations.**

If you're using WordPress, we've made it easy for you. Download the SQweb plugin [directly from WordPress.org](https://wordpress.org/plugins/sqweb/), or [check out the source](https://github.com/SQweb-team/SQweb-WordPress-Plugin).

### With Composer

Composer [requires PHP 5.3.2+ to run](https://getcomposer.org/doc/00-intro.md#system-requirements). If you wish to use Composer, you must update PHP and use [the current version](https://github.com/SQweb-team/SQweb-SDK-PHP) of this SDK.

### Manually

1. Download [the latest release](https://github.com/SQweb-team/SQweb-SDK-PHP/releases) of the SDK and unzip it in a folder named `sqweb` in your project root.
2. Create a file named `sqweb.config` at the root of your project. This file should be one level up from the sqweb folder you just created, i.e. :

    ```text
    |–- sqweb/
    |   |-- src/
    |   |   |-- init.php
    |   |   |-- SQweb.php
    |-- sqweb.config
    ```

3. In `sqweb.config`, paste the following configuration:

    ```text
    SQW_ID_SITE=YOUR_WEBSITE_ID
    SQW_SITENAME=YOUR_WEBSITE_NAME
    SQW_LANG=en
    ```

    **Change `SQW_ID_SITE` with your website ID and `SQW_SITENAME` with the name to show on the large Multipass button**.

For additional settings, see "[Options](#options)" below.

## Usage

### 1. Initializing the SDK

First, you have to initialise SQweb variable on the pages where you wish to use it.

```php
include_once "whereYouInstalled/src/init.php";
```

### 2. Tagging your pages

Then, you need to add our JavaScript tag to your pages. This function will do it for you, and should be inserted before the closing `</body>` tag in your HTML.

```php
$sqweb->script();
```

Make sure it is present on all your pages. Most likely you'll just have to add it to your template.

**If you previously had a SQweb JavaScript tag, make sure to remove it to avoid any conflicts.**

### 3. Checking the credits of your subscribers

Check if the user has credits, so that you can disable ads and/or unlock premium content.

```php
if ($sqweb->checkCredits() > 0) {
    // CONTENT
} else {
    // ADS
}
```

### 4. Showing the Multipass button

Use this code to display the Multipass button on your pages:

```php
$sqweb->button();
```

We have 3 additionals sizes for the button, to use it, pass a string to the function:

```php
$sqweb->button('tiny');
$sqweb->button('slim');
$sqweb->button('large');
```

![Example Buttons](https://cdn.multipass.net/github/buttons@2x.png "Example Buttons")

### 5. More functions

#### Display a support div for your users
```php
/**
 * Display a "Support us" message.
 */

function supportBlock() {   }
``

For instance:

```php
$sqweb = new SQweb;

$sqweb->supportBlock();
```

Will display the block.

#### Display a locking div for your users
```php
/**
 * Display a locking block.
 */

function lockingBlock() {   }
``

For instance:

```php
$sqweb = new SQweb;

$sqweb->lockingBlock();
```

We recommend that you use it with our other blocking function :

```php
if ($sqweb->waitToDisplay('15/09/16', 'd/m/y', 2)) {
    // The content here will appear 2 days after the publication date for non paying users.
} else {
    // Here you can put content that free users will see until the content above is available for all.
    $sqweb->lockingBlock();
}
```

#### Display only a part of your content to non premium users

```php
/**
 * Put opacity to your text
 * Returns text  with opacity style.
 * @param $text  Text you want to limit.
 * @param int $percent Percent of your text you want to show.
 * @return string
 */

function transparent($text, $percent = 100) { ... }
```

For instance:

```php
echo $sqweb->transparent('one two three four', 50);
```

Free users will see:

```text
one two
```

#### Display your content later for non paying users

```php
/*
 * @param string $date  When to publish the content on your site. It must be an ISO format(YYYY-MM-DD).
 * @param int $wait  Number of days you want to wait before showing this content to free users.
 */

function waitToDisplay($date, $wait = 0) { ... }
```

Example:

```php
if ($sqweb->waitToDisplay('15/09/16', 'd/m/y', 2)) {
    // The content here will appear 2 days after the publication date for non paying users.
} else {
    // Here you can put content that free users will see until the content above is available for all.
}
```

#### Limit the number of articles free users can read per day

For instance, if I want to display only 5 articles to free users:

```php
if ($sqweb->limitArticle(5) === true) {
    echo "This is my article";
} else {
    echo "Sorry, you reached the limit of pages you can see today, come back tomorrow or subscribe to Multipass to get unlimited articles !";
}
```

## Options

Unless otherwise noted, these options default to `false`. You can set them in your configuration.

|Option|Description
|---|---|
|`SQW_MESSAGE`|A custom message that will be shown to your adblockers. Quotes must be escaped.|
|`SQW_ADBLOCK_MODAL`|Automatically display the Multipass modal to detected adblockers.|
|`SQW_TARGETING`|Only show the button to detected adblockers. Cannot be combined with `beacon` mode.|
|`SQW_BEACON`|Monitor adblocking rates quietly, without showing any button or banner to the end users.|
|`SQW_DEBUG`|Output various messages to the browser console while the plugin executes.|
|`SQW_DWIDE`|Set to `false` to only enable SQweb on the current domain. Defaults to `true`.|
|`SQW_LANG`|You may pick between `en` and `fr`.|

## Known Issues

If you change the value of `SQW_DWIDE` after initial deployment, your users will have to log in again since their auth cookie will no longer be valid.

## Troubleshooting

### I am not seeing the Multipass button

Please make sure you have properly [initialized the SDK](#1-initializing-the-sdk) and [tagged your pages](#2-tagging-your-pages). Mind the position of the include and tag.

### I can see the Multipass button, but I cannot login

The authentication requires cookies, which require [fully qualified domain names](https://en.wikipedia.org/wiki/Fully_qualified_domain_name). If you are testing on localhost or an IP, the authentication will succeed but won't be able to save a cookie in your browser.

## Contributing

We welcome contributions and improvements.

**Please bear in mind that since this SDK targets an End Of Life version of PHP, we may be unable to maintain feature parity with the current version of the PHP SDK.**

### Coding Style

All PHP code must conform to the [PSR2 Standard](http://www.php-fig.org/psr/psr-2/).

### Builds and Releases

See [RELEASE.md](RELEASE.md).

## Bugs and Security Vulnerabilities

If you encounter any bug or unexpected behavior, you can either report it on Github using the bug tracker, or via email at `hello@sqweb.com`. We will be in touch as soon as possible.

If you discover a security vulnerability within SQweb or this plugin, please send an e-mail to `security@sqweb.com`. Security vulnerabilities will be promptly addressed.

**Please bear in mind that since this SDK targets an End Of Life version of PHP, we may be unable to provide patches.**

## License

Copyright (C) 2015-2017 – SQweb

This program is free software ; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation ; either version 3 of the License, or any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY ; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details

You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.
