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
	spawnObstacles()
	for i in range(50):
		spawnEnemy(0)

func _on_spawn_timer_timeout() -> void:
	spawnEnemy(-1)

func spawnEnemy(index):
	var fishTypeToSpawn = rng.randi_range(0, 100)
	var fishIndex
	if fishTypeToSpawn >= 0 and fishTypeToSpawn <= 60:
		fishIndex = 0
	elif fishTypeToSpawn >= 61 and fishTypeToSpawn <= 90:
		fishIndex = 1
	elif fishTypeToSpawn >= 91 and fishTypeToSpawn <= 100:
		fishIndex = 2
	if index >= 0:
		fishIndex = index
	var enemyToAdd = enemyList[fishIndex].instantiate()
	var posToSpawn = get_tree().get_nodes_in_group("spawnpoint").pick_random().position
	enemyToAdd.position = posToSpawn
	gameManager.add_child(enemyToAdd)

func spawnObstacles():
	for i in range(100):
		var coords = Vector2(rng.randf_range(-5000, 5000), rng.randf_range(-5000, 5000))
		var t = treeObstacle.instantiate()
		t.position = coords
		gameManager.add_child(t)
