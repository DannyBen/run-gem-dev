require 'fileutils'

module RunGemDev

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
			Dir.exist? gemdir or FileUtils.mkdir gemdir
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

end