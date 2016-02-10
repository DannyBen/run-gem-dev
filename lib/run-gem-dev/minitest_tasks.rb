module RunGemDev

	def self.minitest_tasks(pattern="./test/*_test.rb")
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

end