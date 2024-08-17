extends Area2D

@export var projSpeed: float
var dir: Vector2

func _process(delta: float) -> void:
	position += dir * projSpeed * delta

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		area.get_parent().tookDamage()
