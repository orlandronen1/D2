# frozen_string_literal: true

require_relative 'process'

exit 1 unless check_args ARGV

seed = ARGV[0].to_i
num_prospectors = ARGV[1].to_i
num_turns = ARGV[2].to_i

init_towns seed

init_prospectors num_prospectors

prospector_journey num_turns
