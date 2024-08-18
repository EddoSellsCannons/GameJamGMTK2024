extends Node2D

@onready var player = $frogPlayer
@onready var spawnManager = $spawnManager

@onready var anim_player = $CanvasLayer/AnimationPlayer

@onready var all_sfx: Node = $allSFX


func _ready() -> void:
	$CanvasLayer/popUp.visible = true
	$CanvasLayer/AnimationPlayer.play("startLevel")
	get_tree().paused = true

func next_level():
	get_tree().change_scene_to_file("res://Scenes/game_manager_4.tscn")

func _process(delta: float) -> void:
	if player.size >= 120:
		$CanvasLayer/AnimationPlayer.play("levelTransition")
	$CanvasLayer/TextureProgressBar.value = player.stamina

func _on_button_button_down() -> void:
	$CanvasLayer/popUp.visible = false
	get_tree().paused = false
