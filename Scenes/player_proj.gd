extends Area2D

@export var projSpeed = 300
var dir

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		area.tookDamage()

func _process(delta: float) -> void:
	position += projSpeed * dir * delta
