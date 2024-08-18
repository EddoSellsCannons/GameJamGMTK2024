extends Node2D

func _on_start_button_button_down() -> void:
	$microbe/AnimationPlayer.play("levelTransition")

func start_game():
	get_tree().change_scene_to_file("res://Scenes/game_manager.tscn")

func _on_quit_button_button_down() -> void:
	get_tree().quit()

func _on_h_slider_value_changed(value: float) -> void:
	$Camera2D.zoom = Vector2(value, value)
	if value >= 0.1:
		$forest.visible = false
	else:
		$forest.visible = true
	if value >= 0.55:
		$water.visible = false
	else:
		$water.visible = true
