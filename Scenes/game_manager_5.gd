extends Node2D

@onready var anim_player = $AnimationPlayer
@onready var all_sfx: Node = $allSFX
@onready var cutscene_player: CharacterBody2D = $"Cutscene player"


func _ready() -> void:
	$CanvasLayer/popUp.visible = true
	anim_player.play("startLevel")
	get_tree().paused = true

func next_level():
	get_tree().change_scene_to_file("res://Scenes/title_screen.tscn")

func _on_button_button_down() -> void:
	$CanvasLayer/popUp.visible = false
	get_tree().paused = false

func _on_nuclear_area_entered(area: Area2D) -> void:
	anim_player.play("beginFinalCutscene")
	cutscene_player.cut_controls()
