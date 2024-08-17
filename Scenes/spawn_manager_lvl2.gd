extends Node2D

@onready var S_fish = preload("res://Scenes/s_microbe.tscn")
@onready var M_fish = preload("res://Scenes/m_microbe.tscn")
@onready var L_fish = preload("res://Scenes/l_microbe.tscn")

@onready var enemyList = [S_fish, M_fish, L_fish]

@onready var gameManager = $".."

func _ready() -> void:
	for i in range(50):
		await get_tree().create_timer(0.1).timeout 
		spawnEnemy()

func _on_spawn_timer_timeout() -> void:
	spawnEnemy()

func spawnEnemy():
	var enemyToAdd = enemyList.pick_random().instantiate()
	var posToSpawn = get_tree().get_nodes_in_group("spawnpoint").pick_random().position
	enemyToAdd.position = posToSpawn
	gameManager.add_child(enemyToAdd)
