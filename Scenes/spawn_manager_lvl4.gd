extends Node2D

var rng = RandomNumberGenerator.new()

@onready var S_fish = preload("res://Scenes/s_animal.tscn")
@onready var M_fish = preload("res://Scenes/m_animal.tscn")
@onready var L_defender = preload("res://Scenes/l_cityDefender.tscn")

@onready var buildingObstacle = preload("res://Scenes/buildingObstacle.tscn")

@onready var enemyList = [S_fish, M_fish, L_defender]

@onready var gameManager = $".."

func _ready() -> void:
	await get_tree().create_timer(0.5).timeout 
	for i in range(10):
		spawnObstacles()
	spawnEnemy()

func _on_spawn_timer_timeout() -> void:
	spawnObstacles()

func spawnEnemy():
	var enemyToAdd = enemyList[2].instantiate()
	var posToSpawn = get_tree().get_nodes_in_group("spawnpoint").pick_random().position
	enemyToAdd.position = posToSpawn
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
