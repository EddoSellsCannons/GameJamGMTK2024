extends StaticBody2D

var proj = preload("res://Scenes/TreeProj.tscn")

@onready var gameManager = $".."

var canTrample = false

func _ready() -> void:
	$trampleZone.visible = true

func _on_detection_radius_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		$AnimationPlayer.play("throwProjectile")

func launchProj():
	var projToLaunch = proj.instantiate()
	projToLaunch.dir = (gameManager.player.position - position).normalized()
	projToLaunch.position = position
	gameManager.add_child(projToLaunch)

func _process(delta: float) -> void:
	if gameManager.player.size >= 500:
		canTrample = true
		$CollisionShape2D.disabled = true
		$trampleZone.visible = false
	else:
		canTrample = false
		$CollisionShape2D.disabled = false
		$trampleZone.visible = true

func _on_trample_zone_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		if area.get_parent().size >= 500:
			gameManager.all_sfx.playShootPoisonSound()
			queue_free()
