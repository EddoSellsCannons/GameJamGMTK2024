extends Node2D
var rng = RandomNumberGenerator.new()

@onready var S_microbe = preload("res://Scenes/s_microbe.tscn")
@onready var M_microbe = preload("res://Scenes/m_microbe.tscn")
@onready var L_microbe = preload("res://Scenes/l_microbe.tscn")

@onready var enemyList = [S_microbe, M_microbe, L_microbe]

@onready var gameManager = $".."

func _ready() -> void:
	for i in range(50):
		await get_tree().create_timer(0.1).timeout 
		spawnEnemy()

func _on_spawn_timer_timeout() -> void:
	spawnEnemy()

func spawnEnemy():
	var enemyTypeToSpawn = rng.randi_range(0, 100)
	var enemyIndex
	if enemyTypeToSpawn >= 0 and enemyTypeToSpawn <= 80:
		enemyIndex = 0
	elif enemyTypeToSpawn >= 81 and enemyTypeToSpawn <= 94:
		enemyIndex = 1
	elif enemyTypeToSpawn >= 95 and enemyTypeToSpawn <= 100:
		enemyIndex = 2
	var enemyToAdd = enemyList[enemyIndex].instantiate()
	var posToSpawn = get_tree().get_nodes_in_group("spawnpoint").pick_random().position
	enemyToAdd.position = posToSpawn
	gameManager.add_child(enemyToAdd)
