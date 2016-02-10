require 'minitest/autorun'
require 'run-gem-dev/version'
require 'yaml'
require 'colsole'

class RunGemDevTest < Minitest::Test
	include Colsole
	
	def test_cases
		conf = YAML.load_file 'test/cases.yml'
		conf.each do |test|
			say "!txtgrn!#{test['cmd']}"
			output = `#{test['cmd']}`.strip 
			expected = test['out'] % { version: RunGemDev::VERSION }
			if test['chk'] == 'regex'
				assert_match /#{expected}/m, output
			else
				assert_equal expected, output
			end
			# test['has'] and assert File.file?(test['has'])
			# test['del'] and File.delete test['has']
		end
	end

	# Minitest.after_run do
	# 	puts "After Run Hook: Removing #{@@dir}"
	# 	FileUtils.rm_r @@dir
	# end
end