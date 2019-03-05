require 'minitest/autorun'

require_relative 'prospector'

class ProspectorTest < Minitest::Test

	# Creates a consistent Prospector and mock Town
	def setup
		@t = Minitest::Mock.new("town")
		def @t.name; "Mock Town"; end
		@p = Prospector::new 1, @t
	end

	# Ensures construction makes a non-nil and valid Prospector object
	def test_init_not_nil
		refute_nil @p
		assert_kind_of Prospector, @p
	end

	# UNIT TESTS FOR METHOD look_for_rubies()
	# x = rubies found, y = fake rubies found
	# Equivalence classes:
	# x = 0 and y = 0 -> returns false
	# x > 0 or y > 0  -> returns true
	# In each case, @p.days should increment

	# Finding no rubies or fake rubies
	def test_looking_nothing_found
		def @t.find_rubies; 0; end
		def @t.find_fake_rubies; 0; end

		assert_equal false, @p.look_for_rubies
		assert_equal 1, @p.days
	end

	# Finding only rubies
	def test_looking_rubies_found
		def @t.find_rubies; 1; end
		def @t.find_fake_rubies; 0; end

		assert_equal true, @p.look_for_rubies
		assert_equal 1, @p.days
	end

	# Finding only fake rubies
	def test_looking_fake_rubies_found
		def @t.find_rubies; 0; end
		def @t.find_fake_rubies; 1; end

		assert_equal true, @p.look_for_rubies
		assert_equal 1, @p.days
	end

	# Finding both rubies and fake_rubies
	def test_looking_both_found
		def @t.find_rubies; 1; end
		def @t.find_fake_rubies; 1; end

		assert_equal true, @p.look_for_rubies
		assert_equal 1, @p.days
	end

	# Look for more than one day
	def test_looking_several_days
		def @t.find_rubies; 1; end
		def @t.find_fake_rubies; 1; end

		@p.look_for_rubies
		@p.look_for_rubies
		@p.look_for_rubies
		assert_equal 3, @p.days
	end

	# UNIT TESTS FOR METHOD print_findings()
	# x = rubies found, y = fake rubies found
	# Equivalence classes:
	# x = 0, y = 0 -> prints no rubies/fake rubies found
	# x = 1 -> prints that one ruby was found
	# x > 1 -> prints that multiple rubies were found
	# y = 1 -> prints that one fake ruby was found
	# y > 1 -> prints that multiple fake rubies were found

	# Finding no rubies or fake rubies, print special message
	# EDGE CASE
	def test_print_findings_nothing_found
		def @t.find_rubies; 0; end
		def @t.find_fake_rubies; 0; end

		@p.look_for_rubies
		assert_output ("\tFound no rubies or fake rubies in #{@p.town.name}.\n") {@p.print_findings}
	end

	# Finding only 1 ruby
	def test_print_findings_1_ruby_found
		def @t.find_rubies; 1; end
		def @t.find_fake_rubies; 0; end

		@p.look_for_rubies
		assert_output ("\tFound 1 ruby in #{@p.town.name}.\n") {@p.print_findings}
	end

	# Finding several rubies and a fake ruby
	def test_print_findings_rubies_and_fake_ruby_found
		def @t.find_rubies; 2; end
		def @t.find_fake_rubies; 1; end

		@p.look_for_rubies
		assert_output ("\tFound 2 rubies and 1 fake ruby in #{@p.town.name}.\n") {@p.print_findings}
	end

	# Finding only several fake rubies
	def test_print_findings_fake_rubies_found
		def @t.find_rubies; 0; end
		def @t.find_fake_rubies; 2; end

		@p.look_for_rubies
		assert_output ("\tFound 2 fake rubies in #{@p.town.name}.\n") {@p.print_findings}
	end

	# UNIT TESTS FOR METHOD going_home()
	# Equivalence classes:
	# 0 rubies found   -> "Going home empty handed."
	# 1-9 rubies found -> "Going home sad."
	# 10+ rubies found -> "Going home victorious!"

	# No rubies found
	def test_going_home_empty_handed
		assert_output ("Going home empty-handed.\n") {@p.going_home}
	end

	# Between 1-9 rubies found
	def test_going_home_sad
		def @t.find_rubies; 3; end
		def @t.find_fake_rubies; 0; end

		@p.look_for_rubies
		assert_output ("Going home sad.\n") {@p.going_home}
	end

	# 10 rubies found
	def test_going_home_victorious
		def @t.find_rubies; 10; end
		def @t.find_fake_rubies; 0; end

		@p.look_for_rubies
		assert_output ("Going home victorious!\n") {@p.going_home}
	end

	# UNIT TESTS FOR METHOD move()
	# Equivalence classes:
	# No neighboring towns -> town stays the same
	# Neighboring towns -> return one of the neighbors
	# Visits should increment in each case

	# No neighboring towns. This should never happen, but to avoid problems,
	#  the prospector doesn't move to a nil town, but their visits increments
	#  to prevent infinite loops.
	# EDGE CASE
	def test_move_nowhere
		def @t.next; nil; end
		@p.move
 		assert_equal 1, @p.visits
 		assert_equal @t, @p.town
	end

	# Move to a neighbor
	def test_move_somewhere
		def @t.next
			tnext = Minitest::Mock.new("town2")
			tnext.expect(:name,"Next Mock Town")
		end
		assert_output ("Heading from Mock Town to Next Mock Town.\n") {@p.move}
		assert_equal 1, @p.visits
		refute_equal @t, @p.town
	end

	# UNIT TESTS FOR METHOD print_start()
	# This just displays the Prospector's id and starting town

	def test_print_start
		assert_output ("Rubyist #1 starting in Mock Town.\n") {@p.print_start}
	end

	# UNIT TESTS FOR METHOD print_total_findings()
	# Equivalence classes:
	# 1 ruby found -> prints "1 ruby."
	# x != 1 rubies found -> prints "x rubies."
	# 1 fake ruby found -> prints "1 fake ruby."
	# x != 1 fake rubies found -> prints "x fake rubies."

	# 1 ruby and 1 fake ruby found
	def test_print_total_findings_one_each
		def @t.find_rubies; 1; end
		def @t.find_fake_rubies; 1; end;
		@p.look_for_rubies
		assert_output ("After 1 days, Rubyist #1 found:\n\t1 ruby.\n\t1 fake ruby.\n") {@p.print_total_findings}
	end

	# 2 ruby and 0 fake ruby found
	def test_print_total_findings_not_one_each
		def @t.find_rubies; 2; end
		def @t.find_fake_rubies; 0; end;
		@p.look_for_rubies
		assert_output ("After 1 days, Rubyist #1 found:\n\t2 rubies.\n\t0 fake rubies.\n") {@p.print_total_findings}
	end
end