Run Gem Dev
===========

[Runfile](https://github.com/DannyBen/runfile) tasks for gem developers.

## Install

	$ gem install run-gem-dev

## Usage

Put this in your Runfile

```ruby
require "run-gem-dev"

name    "My Gem Runfile"
summary "Tasks for my gem"
version "0.1.0"

RunGemDev::Tasks.embed 'run-gem-dev'

# Your other tasks here

```

## Available Tasks

	run gem build [<folder>]
	run gem install
	run gem publish
	run gem test [<name>]


## Todo

- Docs
- Tests
- Yank `gem yank gemname -v 0.1.0`