extends Node2D

@onready var S_microbe = preload("res://Scenes/s_microbe.tscn")
@onready var M_microbe = preload("res://Scenes/m_microbe.tscn")
@onready var L_microbe = preload("res://Scenes/l_microbe.tscn")

@onready var enemyList = [S_microbe, M_microbe, L_microbe]

@onready var gameManager = $".."

func _ready() -> void:
	await get_tree().create_timer(1).timeout 
	for i in range(50):
		spawnEnemy()

func _on_spawn_timer_timeout() -> void:
	spawnEnemy()

func spawnEnemy():
	var enemyToAdd = enemyList.pick_random().instantiate()
	var posToSpawn = get_tree().get_nodes_in_group("spawnpoint").pick_random().position
	enemyToAdd.position = posToSpawn
	gameManager.add_child(enemyToAdd)
