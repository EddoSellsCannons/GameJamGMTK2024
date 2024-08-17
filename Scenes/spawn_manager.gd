extends Node2D

@onready var S_microbe = preload("res://Scenes/s_microbe.tscn")
@onready var gameManager = $".."

func _on_spawn_timer_timeout() -> void:
	var enemyToAdd = S_microbe.instantiate()
	var posToSpawn = get_tree().get_nodes_in_group("spawnpoint").pick_random().position
	enemyToAdd.position = posToSpawn
	gameManager.add_child(enemyToAdd)
