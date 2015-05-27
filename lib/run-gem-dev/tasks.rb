
module RunGemDev
	def self.tasks(gemname, gemdir="gems")
		command "gem"

		spec = Gem::Specification::load "#{gemname}.gemspec"
		spec or abort "Error loading #{gemname}.gemspec"
		gemver = spec.version.to_s
		
		usage  "build [--install]"
		help   "Build gem from gemspec and move it to '#{gemdir}' folder.\nUse --install to also install it."
		action :build do |args|
			say "Building gem..."
			cmd = "gem build #{gemname}.gemspec"	
			say "Running: #{cmd}"
			system cmd
			say "Moving to #{gemdir}..."
			files = Dir["*.gem"]
			files.each {|f| FileUtils.mv f, gemdir }
			args['--install'] and call "gem install"
		end

		help   "Install local gem"
		action :install do
			gemfile = "gems/#{gemname}-#{gemver}.gem"
			cmd = "gem install #{gemfile}"
			say "Running: #{cmd}"
			system cmd
		end

		help   "Publish gem to rubygems"
		action :publish do
			gemfile = "gems/#{gemname}-#{gemver}.gem"
			File.exist? gemfile or abort "File not found #{gemfile}"
			cmd = "gem push #{gemfile}"
			say "Running: #{cmd}"
			system cmd
		end

		usage  "yank [<version>]"
		help   "Yank gem from rubygems"
		action :yank do |args|
			ver = args['<version>'] || gemver
			cmd = "gem yank #{gemname} -v #{ver}"
			say "Running: #{cmd}"
			system cmd
		end			

		usage  "test [<name>]"
		help   "Run all tests or a single test file"
		action :test do |args|
			name = args['<name>'] || "*"
			cmd = "ruby -Itest test/test_#{name}.rb"
			say "Running: #{cmd}"
			system cmd
		end

		endcommand
	end

end