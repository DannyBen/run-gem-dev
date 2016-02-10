Run Gem Dev
===========

[![Gem Version](https://badge.fury.io/rb/run-gem-dev.svg)](http://badge.fury.io/rb/run-gem-dev)
[![Build Status](https://travis-ci.org/DannyBen/run-gem-dev.svg?branch=master)](https://travis-ci.org/DannyBen/run-gem-dev)

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

# Add rubygems tasks (publish, install etc.)
RunGemDev::gem_tasks 'my-gem-name'

# Add test task (minitest)
RunGemDev::minitest_tasks

# Add rspec task
RunGemDev::rspec_tasks

# Add rdoc task
RunGemDev::rdoc_tasks

# Your other tasks here
# ...

```

## Available Tasks

	run gem build [--install]
	run gem install [--remote]
	run gem publish
	run gem yank [<version>]
	run test [<name>]
	run spec [<name>]
	run rdoc [-- <options>...]

