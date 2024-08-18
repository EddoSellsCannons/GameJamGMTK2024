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

func _process(delta: float) -> void:
	position += dir * projSpeed * delta

func _on_area_entered(area: Area2D):
	if area.is_in_group("Player"):
		area.get_parent().tookDamage()
		#gameManager.anim_player.play("takeDamagefromPoop")
