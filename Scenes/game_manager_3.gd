extends Node2D

@onready var player = $frogPlayer
@onready var spawnManager = $spawnManager

@onready var anim_player = $CanvasLayer/AnimationPlayer

func next_level():
	get_tree().change_scene_to_file("res://Scenes/game_manager_3.tscn")

func _process(delta: float) -> void:
	if player.size >= 1200:
		next_level()
	$CanvasLayer/TextureProgressBar.value = player.stamina
