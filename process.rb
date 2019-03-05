require_relative 'town'
require_relative 'prospector'

# Checks the command line arguments for correctness
def check_args arguments
	if arguments.length != 3
		puts "There must be exactly three arguments: *seed*, *num_prospectors*, *num_turns*"
		exit 1
	else
		if arguments[1].to_i < 0 or arguments[2].to_i < 0
			puts "Usage:"
			puts "ruby ruby_rush.rb *seed* *num_prospectors* *num_turns*"
			puts "*seed* should be an integer"
			puts "*num_prospectors* should be a non-negative integer"
			puts "*num_turns* should be a non-negative integer"
			exit 1
		end
	end
end

# Sets up Towns
def init_towns seed
	@enumerable_canyon = Town::new "Enumerable Canyon", 1, 1, seed
	@duck_type_beach = Town::new "Duck Type Beach", 2, 2, seed
	@monkey_patch_city = Town::new "Monkey Patch City", 1, 1, seed
	@nil_town = Town::new "Nil Town", 0, 3, seed
	@matzburg = Town::new "Matzburg", 3, 0, seed
	@hash_crossing = Town::new "Hash Crossing", 2, 2, seed
	@dynamic_palisades = Town::new "Dynamic Palisades", 2, 2, seed

	@enumerable_canyon.add_neighbor @duck_type_beach
	@enumerable_canyon.add_neighbor @monkey_patch_city

	@duck_type_beach.add_neighbor @enumerable_canyon
	@duck_type_beach.add_neighbor @matzburg

	@monkey_patch_city.add_neighbor @enumerable_canyon
	@monkey_patch_city.add_neighbor @nil_town
	@monkey_patch_city.add_neighbor @matzburg

	@nil_town.add_neighbor @monkey_patch_city
	@nil_town.add_neighbor @hash_crossing

	@matzburg.add_neighbor @monkey_patch_city
	@matzburg.add_neighbor @duck_type_beach
	@matzburg.add_neighbor @hash_crossing
	@matzburg.add_neighbor @dynamic_palisades

	@hash_crossing.add_neighbor @nil_town
	@hash_crossing.add_neighbor @matzburg
	@hash_crossing.add_neighbor @dynamic_palisades

	@dynamic_palisades.add_neighbor @hash_crossing
	@dynamic_palisades.add_neighbor @matzburg
end

# Sets up prospectors
def init_prospectors num_prospectors
	@prospectors = Array.new(num_prospectors)
	i = 1
	for p in @prospectors
		@prospectors[i-1] = Prospector::new i, @enumerable_canyon
		puts @prospectors[i-1].to_s
		i += 1
	end
end

# Total loop for prospector's journey
def prospector_journey num_turns
	for p in @prospectors
		p.print_start

		while p.visits < num_turns
			found_anything = p.look_for_rubies
			p.print_findings
			if not found_anything #and p.visits <= (num_turns - 1)
				if p.visits < num_turns - 1
					p.move
				elsif p.visits == num_turns - 1
					break
				end
			end
		end

		p.print_total_findings
		p.going_home
	end
end