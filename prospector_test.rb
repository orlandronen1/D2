require 'minitest/autorun'

require_relative 'prospector'
require_relative 'town'

class ProspectorTest < Minitest::Test

	# Creates a consistent Prospector and Town for testing purposes
	def setup
		@t = Town::new "The Town", 2, 3, 12
		@p = Prospector::new 1, @t
	end

	# Ensures construction makes a non-nil and valid Prospector object
	def test_init_not_nil
		refute_nil @p
		assert_kind_of Prospector, @p
	end