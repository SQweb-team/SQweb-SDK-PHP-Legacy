#!/bin/bash

# SQWEB - PHP SDK LEGACY - RELEASE NOTIFIER
# ------------------------------------------------------------------------------
# Let the Slack team know that the release was successful.

curl -X "POST" "https://hooks.slack.com/services/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" \
	 -H "Content-Type: application/x-www-form-urlencoded; charset=utf-8" \
	 --data-urlencode "payload={\"text\": \"$TRAVIS_TAG released on GitHub.\"}"
