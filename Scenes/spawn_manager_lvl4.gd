extends Node2D

var rng = RandomNumberGenerator.new()

@onready var L_burger = preload("res://Scenes/l_burger.tscn")
@onready var L_donut = preload("res://Scenes/l_donut.tscn")
@onready var L_defender = preload("res://Scenes/l_cityDefender.tscn")

@onready var buildingObstacle = preload("res://Scenes/buildingObstacle.tscn")

@onready var enemyList = [L_burger, L_donut, L_defender]

@onready var gameManager = $".."

func _ready() -> void:
	await get_tree().create_timer(0.5).timeout 
	createBoss()
	createBoss()
	for i in range(10):
		spawnObstacles()
		spawnEnemy()

func createBoss():
	var enemyToAdd = enemyList[2].instantiate() #Create boss
	var posToSpawn = get_tree().get_nodes_in_group("spawnpoint").pick_random().position
	enemyToAdd.position = posToSpawn
	gameManager.add_child(enemyToAdd)

func _on_spawn_timer_timeout() -> void:
	spawnObstacles()
	spawnEnemy()

func spawnEnemy():
	for i in range(5):
		var enemyTypeToSpawn = rng.randi_range(0, 100)
		var enemyIndex
		if enemyTypeToSpawn >= 0 and enemyTypeToSpawn <= 50:
			enemyIndex = 0
		elif enemyTypeToSpawn >= 51 and enemyTypeToSpawn <= 100:
			enemyIndex = 1
		var enemyToAdd = enemyList[enemyIndex].instantiate()
		var coords = Vector2(rng.randf_range(gameManager.player.position.x + 500, gameManager.player.position.x + 5000), rng.randf_range(gameManager.player.position.y + 500, gameManager.player.position.y + 5000))
		var xNegMultiplier = rng.randi_range(0, 1)
		var yNegMultiplier = rng.randi_range(0, 1)
		if xNegMultiplier == 0:
			coords.x *= -1
		if yNegMultiplier == 0:
			coords.y *= -1
		enemyToAdd.position = coords
		gameManager.add_child(enemyToAdd)

func spawnObstacles():
	for i in range(10):
		var coords = Vector2(rng.randf_range(gameManager.player.position.x + 500, gameManager.player.position.x + 5000), rng.randf_range(gameManager.player.position.y + 500, gameManager.player.position.y + 5000))
		var xNegMultiplier = rng.randi_range(0, 1)
		var yNegMultiplier = rng.randi_range(0, 1)
		if xNegMultiplier == 0:
			coords.x *= -1
		if yNegMultiplier == 0:
			coords.y *= -1
		var t = buildingObstacle.instantiate()
		t.position = coords
		gameManager.add_child(t)
