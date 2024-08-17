extends Node2D

@onready var player = $fishPlayer
@onready var spawnManager = $spawnManager

func next_level():
	get_tree().change_scene_to_file("res://Scenes/game_manager_2.tscn")

func _process(delta: float) -> void:
	if player.size >= 1200:
		next_level()
	$CanvasLayer/TextureProgressBar.value = player.stamina
