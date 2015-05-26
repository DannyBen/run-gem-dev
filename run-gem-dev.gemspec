lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'run-gem-dev/version'

Gem::Specification.new do |s|
  s.name        = 'run-gem-dev'
  s.version     = RunGemDev::VERSION
  s.date        = Date.today.to_s
  s.summary     = "Runfile tasks for gem developers"
  s.description = "A collection of gem related tasks for Runfile"
  s.authors     = ["Danny Ben Shitrit"]
  s.email       = 'db@dannyben.com'
  s.files       = Dir['README.md', 'lib/**/*.rb']
  s.homepage    = 'https://github.com/DannyBen/run-gem-dev'
  s.license     = 'MIT'

  s.add_runtime_dependency 'runfile', '~> 0.3'
  s.add_development_dependency 'minitest', '~> 5.6'
end
