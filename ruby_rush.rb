if ARGV.length != 3
	puts "Not enough arguments"
	exit 1
else
	# TODO check for integerness
	for arg in ARGV
		if arg.to_i < 0
			puts "Argument #{arg} is not a non-negative integer"
		end
	end
end