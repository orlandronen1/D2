class Prospector

	attr_reader :id, :town, :rubies, :fake_rubies, :days

	# Initializes Prospector with an ID number and a starting Town
	def initialize id, town
		@id = id
		@town = town
		@rubies = 0
		@fake_rubies = 0
		@days = 0
		@visits = 0
	end

	# Looks for and increments rubies
	def look_for_rubies
		r_found = @town.find_rubies
		fr_found = @town.find_fake_rubies

		@rubies += r_found
		@fake_rubies += fr_found

		if r_found + fr_found == 0
			puts "\tFound no rubies or fake rubies in #{@town.name}"
		else
			print "Found"

			# Print info on rubies found, if any
			if r_found == 0
				print " "
			elsif r_found == 1
				print " #{r_found} ruby"
			else
				print " #{r_found} rubies"
			end

			if r_found >= 1 and fr_found >= 1
				print " and "
			end

			# Print info on fake rubies found, if any
			if fr_found == 0
				print " "
			elsif fr_found == 1
				print " #{fr_found} fake ruby"
			else
				print " #{fr_found} fake rubies"
			end

			# Print town info
			puts " in #{@town.name}"

			# Return true if anything found, false otherwise
			(r_found + fr_found) > 0
		end

		# Prints out Prospector's going home message
		def going_home
			if @rubies == 0
				puts "Going home empty-handed"
			elsif @rubies >= 10
				puts "Going home victorious!"
			else
				puts "Going home sad."
			end
		end
	end


end