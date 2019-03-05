# frozen_string_literal: true

require_relative 'town'
require_relative 'prospector'

# Checks the command line arguments for correctness
def check_args(arguments)
  if arguments.length != 3
    puts 'There must be exactly three arguments: *seed*, *num_prospectors*, *num_turns*'
    return false
  elsif arguments[1].to_i.negative? || arguments[2].to_i.negative?
    puts 'Usage:'
    puts 'ruby ruby_rush.rb *seed* *num_prospectors* *num_turns*'
    puts '*seed* should be an integer'
    puts '*num_prospectors* should be a non-negative integer'
    puts '*num_turns* should be a non-negative integer'
    return false
  end
  true
end

# Sets up Towns
def init_towns(seed)
  @enumerable_canyon = Town.new 'Enumerable Canyon', 1, 1, seed
  @duck_type_beach = Town.new 'Duck Type Beach', 2, 2, seed
  @monkey_patch_city = Town.new 'Monkey Patch City', 1, 1, seed
  @nil_town = Town.new 'Nil Town', 0, 3, seed
  @matzburg = Town.new 'Matzburg', 3, 0, seed
  @hash_crossing = Town.new 'Hash Crossing', 2, 2, seed
  @dynamic_palisades = Town.new 'Dynamic Palisades', 2, 2, seed

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
def init_prospectors(num_prospectors)
  @prospectors = Array.new(num_prospectors)
  i = 1
  while i <= num_prospectors
    @prospectors[i - 1] = Prospector.new i, @enumerable_canyon
    i += 1
  end
end

# Total loop for prospector's journey
def prospector_journey(num_turns)
  i = 0
  while i < @prospectors.count
    @prospectors[i].print_start

    while @prospectors[i].visits < num_turns
      found_anything = @prospectors[i].look_for_rubies
      @prospectors[i].print_findings
      # Has more visits they can make
      if @prospectors[i].visits < num_turns - 1 && !found_anything
        @prospectors[i].move
      # No more visits to make, don't move again before returning
      elsif @prospectors[i].visits == num_turns - 1 && !found_anything
        break
      end
    end

    @prospectors[i].print_total_findings
    @prospectors[i].going_home

    i += 1
  end
end
