extends Node2D

var rng = RandomNumberGenerator.new()

@onready var S_fish = preload("res://Scenes/s_fish.tscn")
@onready var M_fish = preload("res://Scenes/m_fish.tscn")
@onready var L_fish = preload("res://Scenes/l_fish.tscn")

@onready var enemyList = [S_fish, M_fish, L_fish]

@onready var gameManager = $".."

func _ready() -> void:
	for i in range(50):
		await get_tree().create_timer(0.1).timeout 
		spawnEnemy()

func _on_spawn_timer_timeout() -> void:
	spawnEnemy()

func spawnEnemy():
	var fishTypeToSpawn = rng.randi_range(0, 100)
	var fishIndex
	if fishTypeToSpawn >= 0 and fishTypeToSpawn <= 80:
		fishIndex = 0
	elif fishTypeToSpawn >= 81 and fishTypeToSpawn <= 94:
		fishIndex = 1
	elif fishTypeToSpawn >= 95 and fishTypeToSpawn <= 100:
		fishIndex = 2
	var enemyToAdd = enemyList[fishIndex].instantiate()
	var posToSpawn = get_tree().get_nodes_in_group("spawnpoint").pick_random().position
	enemyToAdd.position = posToSpawn
	gameManager.add_child(enemyToAdd)
