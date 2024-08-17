extends Node2D

@export var tilemap: TileMap  # Reference to your TileMap node
@export var chunk_size = 16  # Size of each chunk (in tiles)
@export var tile_size = 16  # Size of each tile (in pixels)

# Dictionary to keep track of generated chunks
var generated_chunks = {}

func _ready():
	# Start generating chunks around the player's initial position
	update_chunks()

func _process(delta):
	update_chunks()

func update_chunks():
	# Get the player's global position
	var player_position = $"../playerMicrobe".global_position
	
	# Calculate the player's current chunk coordinates
	var chunk_x = int(player_position.x / (chunk_size * tile_size))
	var chunk_y = int(player_position.y / (chunk_size * tile_size))
	
	# Generate and load chunks around the player (e.g., 3x3 chunks)
	for x in range(chunk_x - 8, chunk_x + 8):
		for y in range(chunk_y - 8, chunk_y + 8):
			var chunk_coords = Vector2(x, y)
			if not generated_chunks.has(chunk_coords):
				generate_chunk(chunk_coords)
				generated_chunks[chunk_coords] = true

func generate_chunk(chunk_coords: Vector2):
	# Generate tiles for the chunk
	for x in range(chunk_size):
		for y in range(chunk_size):
			var world_x = int(chunk_coords.x * chunk_size + x)
			var world_y = int(chunk_coords.y * chunk_size + y)
			
			var xCoord = randi_range(0, 1)
			var yCoord = randi_range(0, 1)
			tilemap.set_cell(0, Vector2i(world_x, world_y), 0, Vector2i(xCoord,yCoord))
