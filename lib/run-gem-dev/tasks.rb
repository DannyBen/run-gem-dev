# This module provides Runfile tasks for gem developers.
# The tasks are divided to three categories:
#
# 1. Rubygems tasks (publish, build etc)
# 2. Tests tasks (using minitest)
# 3. Rdoc tasks

module RunGemDev

	@@default_rdoc_options = [
		"--main README.md",
		"--all",
	]

	
	# Add rubygems tasks: build, install, publish and yank
	def self.gem_tasks(gemname, gemdir="gems")
		command "gem"

		spec = Gem::Specification::load "#{gemname}.gemspec"
		spec or abort "Error loading #{gemname}.gemspec"
		gemver = spec.version.to_s

		usage  "build [--install]"
		help   "Build gem from gemspec and move it to '#{gemdir}' folder.\nUse --install to also install it."
		action :build do |args|
			say "!txtgrn!Building gem"
			cmd = "gem build #{gemname}.gemspec"	
			say "!txtgrn!Running: !txtpur!#{cmd}"
			system cmd
			say "!txtgrn!Moving gem file to #{gemdir}"
			files = Dir["*.gem"]
			files.each {|f| FileUtils.mv f, gemdir }
			args['--install'] and call "gem install"
		end

		usage  "install [--remote]"
		help   "Install gem from local gem file or from rubygems (--remote)."
		action :install do |args|
			if args['--remote']
				cmd = "gem install #{gemname}"
			else
				gemfile = "gems/#{gemname}-#{gemver}.gem"
				cmd = "gem install #{gemfile}"
			end
			say "!txtgrn!Running: !txtpur!#{cmd}"
			system cmd
		end

		help   "Publish gem to rubygems. Make sure to 'run gem build' before you publish."
		action :publish do
			gemfile = "gems/#{gemname}-#{gemver}.gem"
			File.exist? gemfile or abort "File not found #{gemfile}"
			cmd = "gem push #{gemfile}"
			say "!txtgrn!Running: !txtpur!#{cmd}"
			system cmd
		end

		usage  "yank [<version>]"
		help   "Yank gem from rubygems."
		action :yank do |args|
			ver = args['<version>'] || gemver
			cmd = "gem yank #{gemname} -v #{ver}"
			say "!txtgrn!Running: !txtpur!#{cmd}"
			system cmd
		end
		
		endcommand
	end

	# Add minitest task
	def self.minitest_tasks(pattern="./test/test_*.rb")
		usage  "test [<name>]"
		help   "Run all tests or a single test file."
		action :test do |args|
			if args['<name>'] 
				file = pattern.sub "*", args['<name>']
				say "!txtgrn!Using: !txtpur!#{file}"
				require file
			else
				Dir[pattern].each do |file| 
					say "!txtgrn!Using: !txtpur!#{file}"
					require file
				end
			end
		end
	end

	# Add rdoc task
	def self.rdoc_tasks(files=nil, options=@@default_rdoc_options)
		files or files = Dir['**/*.{rb,md}']
		files = "'" + files.join("' '") + "'"
		usage  "rdoc [-- <options>...]"
		help   "Generate documentation using the rdoc command line tool. To pass arguments to rdoc, place them after '--'."
		action :rdoc do |args|
			inopts = args['<options>']
			options = inopts unless inopts.empty?
			options = options.join(' ')
			cmd = "rdoc #{options} #{files}"
			say "!txtgrn!Running: !txtpur!#{cmd}"
			system cmd
		end
	end
end