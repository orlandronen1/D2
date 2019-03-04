require 'minitest/autorun'

require_relative 'town'

class TownTest < Minitest::Test

	# This will create a consistent Town for each test
	def setup
		@t = Town::new "TownName", 2, 3, 12
		@t2 = Town::new "NextOne", 0, 0, 3
	end

	# UNIT TESTS FOR METHOD num_neighbors()
	# Equivalence classes:
	# 0 neighbors  -> returns 0
	# >0 neighbors -> returns number of neighbors

	# If no neighbors are added, 0 is returned
	def test_num_neighbors_zero
		assert_equal 0, @t.num_neighbors
	end

	# If x neighbors are added, x is returned
	def test_num_neighbors_nonzero
		@t.add_neighbor @t2
		assert_equal 1, @t.num_neighbors
	end

	# UNIT TESTS FOR METHOD next()
	# Equivalence classes:
	# 0 neighbors  -> returns nil
	# >0 neighbors -> returns a neighbor

	# If no neighbors, returns nil
	def test_next_no_neighbors
		assert_nil @t.next
	end

	# If there's a neighbor, returns that neighbor
	def test_next_one_neighbor
		@t.add_neighbor @t2
		assert_equal @t2, @t.next
	end

	# UNIT TESTS FOR METHOD find_rubies
	# Equivalence classes: 
	# Max = 0 -> returns 0
	# Max = x -> returns 0..x

	# If max_rubies is 0, returns 0
	def test_find_rubies_zero
		assert_equal 0, @t2.find_rubies
	end

	# If max_rubies is x, returns 0..x
	def test_find_rubies_nonzero
		assert_includes 0..@t.max_rubies, @t.find_rubies
	end

	# UNIT TESTS FOR METHOD find_fake_rubies
	# Equivalence classes: 
	# Max = 0 -> returns 0
	# Max = x -> returns 0..x

	# If max_fake_rubies is 0, returns 0
	def test_find_fake_rubies_zero
		assert_equal 0, @t2.find_fake_rubies
	end

	# If max_fake_rubies is x, returns 0..x
	def test_find_fake_rubies_nonzero
		assert_includes 0..@t.max_fake_rubies, @t.find_fake_rubies
	end
end