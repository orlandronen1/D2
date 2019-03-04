class Town

	attr_reader :name, :max_rubies, :max_fake_rubies, :neighbors

	# Initializes the town with name, max ruby, max fake ruby, seed, and neighbors
	def initialize n, max_r, max_faker, seed
		@name = n
		@max_rubies = max_r
		@max_fake_rubies = max_faker
		@random = Random.new(seed)
		# Initialize neighbors to be empty list
		@neighbors = []
	end

	# Returns the number of neighboring Towns
	def num_neighbors
		@neighbors.count
	end

	# Adds a neighboring Town (not needed if initializing w/ neighbors)
	def add_neighbor n
		@neighbors << n
	end

	# Returns a psuedorandomly determined neighbor
	def next
		if not @neighbors.count.zero?
			@neighbors[@random.rand(neighbors.count)]
		else
			nil
		end
	end

	# Returns a psuedorandomly determined amount of rubies found
	def find_rubies
		# Add 1 to max_rubies to make maximum inclusive
		@random.rand(@max_rubies + 1)
	end

	# Returns a psuedorandomly determined amount of fake rubies found
	def find_fake_rubies
		# Add 1 to max_fake_rubies to make maximum inclusive
		@random.rand(@max_fake_rubies + 1)
	end
end