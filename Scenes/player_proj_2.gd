extends Area2D

@export var minProjSpeed = 300
var projSpeed
var dir
var size:float

func _ready() -> void:
	scale = Vector2(size/300, size/300)
	projSpeed = size * 1.2
	if projSpeed < minProjSpeed:
		projSpeed = minProjSpeed

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		area.tookDamage()

func _process(delta: float) -> void:
	position += projSpeed * dir * delta
