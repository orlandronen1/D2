class Prospector

	attr_reader :id, :town, :rubies, :fake_rubies, :days, :visits, :last_ruby_haul, :last_fake_ruby_haul

	# Initializes Prospector with an ID number and a starting Town
	def initialize id, town
		@id = id
		@town = town
		@rubies = 0
		@fake_rubies = 0
		@days = 0
		@visits = 0

		# These are just used for printing purposes
		@last_ruby_haul = 0
		@last_fake_ruby_haul = 0
	end

	# Looks for and increments rubies
	def look_for_rubies
		@last_ruby_haul = @town.find_rubies
		@last_fake_ruby_haul = @town.find_fake_rubies

		@rubies += @last_ruby_haul
		@fake_rubies += @last_fake_ruby_haul

		@days += 1

		# Return true if anything found, false otherwise
		(last_ruby_haul + last_fake_ruby_haul) > 0
	end

	# Prints out starting message
	def print_start
		puts "Rubyist ##{@id} starting in #{@town.name}"
	end

	# Prints messages of number of rubies and fake rubies found
	def print_findings
		if last_ruby_haul + last_fake_ruby_haul == 0
			puts "\tFound no rubies or fake rubies in #{@town.name}."
		else
			print "\tFound"

			# Print info on rubies found, if any
			if last_ruby_haul == 0
				print ""
			elsif last_ruby_haul == 1
				print " #{last_ruby_haul} ruby"
			else
				print " #{last_ruby_haul} rubies"
			end

			if last_ruby_haul >= 1 and last_fake_ruby_haul >= 1
				print " and"
			end

			# Print info on fake rubies found, if any
			if last_fake_ruby_haul == 0
				print ""
			elsif last_fake_ruby_haul == 1
				print " #{last_fake_ruby_haul} fake ruby"
			else
				print " #{last_fake_ruby_haul} fake rubies"
			end

			# Print town info
			puts " in #{@town.name}."
		end
	end

	# Moves Prospector to next Town
	def move
		next_town = @town.next
		if next_town != nil
			puts "Heading from #{@town.name} to #{next_town.name}."
			@town = @town.next
			@visits += 1
		end
	end

	# Prints out total findings
	def print_total_findings
		puts "After #{@days} days, Rubyist ##{@id} found:"

		print "\t#{@rubies} "
		if @rubies == 1
			puts "ruby."
		else
			puts "rubies."
		end

		print "\t#{@fake_rubies} "
		if @fake_rubies == 1
			puts "fake ruby."
		else
			puts "fake rubies."
		end
	end

	# Prints out Prospector's going home message
	def going_home
		if @rubies == 0
			puts "Going home empty-handed."
		elsif @rubies >= 10
			puts "Going home victorious!"
		else
			puts "Going home sad."
		end
	end

	def to_s
		puts "Rubyist ##{@id} is in #{@town.name} with #{@rubies} rubies and #{@fake_rubies} fake rubies after #{@days} days and #{visits} visits."
	end
end