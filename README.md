Run Gem Dev
===========

[![Gem Version](https://badge.fury.io/rb/run-gem-dev.svg)](http://badge.fury.io/rb/run-gem-dev)

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
	run gem yank [<version>]

## Todo

- Docs
- Add `init` (scaffold gemspec and folders)
