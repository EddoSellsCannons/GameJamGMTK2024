extends Node2D

var rng = RandomNumberGenerator.new()

@onready var S_fish = preload("res://Scenes/s_animal.tscn")
@onready var M_fish = preload("res://Scenes/m_animal.tscn")
@onready var L_fish = preload("res://Scenes/l_animal.tscn")

@onready var treeObstacle = preload("res://Scenes/treeObstacle.tscn")

@onready var enemyList = [S_fish, M_fish, L_fish]

@onready var gameManager = $".."

func _ready() -> void:
	await get_tree().create_timer(0.5).timeout 
	for i in range(50):
		spawnEnemy(0)
		spawnObstacles()

func _on_spawn_timer_timeout() -> void:
	spawnEnemy(-1)
	spawnObstacles()

func spawnEnemy(index):
	var fishTypeToSpawn = rng.randi_range(0, 100)
	var fishIndex
	if fishTypeToSpawn >= 0 and fishTypeToSpawn <= 74:
		fishIndex = 0
	elif fishTypeToSpawn >= 75 and fishTypeToSpawn <= 94:
		fishIndex = 1
	elif fishTypeToSpawn >= 95 and fishTypeToSpawn <= 100:
		fishIndex = 2
	if index >= 0:
		fishIndex = index
	var enemyToAdd = enemyList[fishIndex].instantiate()
	var posToSpawn = get_tree().get_nodes_in_group("spawnpoint").pick_random().position
	enemyToAdd.position = posToSpawn
	gameManager.add_child(enemyToAdd)

func spawnObstacles():
	for i in range(5):
		var coords = Vector2(rng.randf_range(gameManager.player.position.x + 500, gameManager.player.position.x + 5000), rng.randf_range(gameManager.player.position.y + 500, gameManager.player.position.y + 5000))
		var xNegMultiplier = rng.randi_range(0, 1)
		var yNegMultiplier = rng.randi_range(0, 1)
		if xNegMultiplier == 0:
			coords.x *= -1
		if yNegMultiplier == 0:
			coords.y *= -1
		var t = treeObstacle.instantiate()
		t.position = coords
		gameManager.add_child(t)
