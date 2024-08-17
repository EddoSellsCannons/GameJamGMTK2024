extends Camera2D

@onready var spawnpoints = [$rightSpawn, $topSpawn, $botSpawn, $leftSpawn]
@onready var player = $".."

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	updateSpawnpointPos()
	
func updateSpawnpointPos():
	for sp in spawnpoints:
		sp.position = player.position
		if sp.name == "rightSpawn":
			sp.position.x += 1000
		elif sp.name == "topSpawn":
			sp.position.y += 800
		elif sp.name == "botSpawn":
			sp.position.y -= 800
		elif sp.name == "leftSpawn":
			sp.position.x -= 1000
