require 'minitest/autorun'

require_relative 'process'
# require_relative 'town'

class TownTest < Minitest::Test

	# UNIT TESTS FOR METHOD check_args(arguments)
	# Equivalence classes:
	# 3 arguments, all valid -> return true
	# 3 arguments, 1+ invalid -> return false
	# Not 3 arguments -> return false

	# Fully valid set of arguments
	def test_check_args_valid
		assert_equal true, check_args([1,2,3])
	end

	# Invalid arguments
	def test_check_args_invalid
		assert_equal false, check_args([1,1,-1])
	end

	# Not 3 arguements
	def test_check_args_not_3_args
		assert_equal false, check_args([1,1,1,1])
	end

  # UNIT TEST FOR METHOD init_towns(seed)
  # Simply testing for non-nil towns, as there 
  #  would be way too many assertations to test for 
  #  total equality
  # Value of seed is arbitrary as it will work regardless

  def test_init_towns
    init_towns(1)
    refute_nil @matzburg
    assert_equal 4, @matzburg.num_neighbors
  end

  # UNIT TEST FOR METHOD init_prospectors(num_prospectors)
  # Simply testing for non-nil prospectors, for same reasons
  #  as for init_towns

  def test_init_prospectors
    init_towns(1)
    init_prospectors(1)
    refute_nil @prospectors[0]
    assert_equal 'Enumerable Canyon', @prospectors[0].town.name
  end
end