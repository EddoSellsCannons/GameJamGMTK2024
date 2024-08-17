extends Area2D

@onready var speed_randomise_timer: Timer = $speedRandomiseTimer

var rng = RandomNumberGenerator.new()
@export var maxSpeed: float
@export var maxSize: float
var speed: float
var dir = Vector2(0,0)
var size

func _ready() -> void:
	size = rng.randf_range(maxSize/2, maxSize)
	scale = Vector2(size/100, size/100)

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		if compareSize(area.get_parent().size):
			area.get_parent().tookDamage()
	
func _process(delta: float) -> void:
	position += dir * speed * delta
	if speed > 0:
		speed -= 1
	elif speed < 0:
		speed += 1
	
func _on_speed_randomise_timer_timeout() -> void:
	speed = rng.randf_range(maxSpeed/2, maxSpeed)
	dir = Vector2(rng.randf_range(-1.0,1.0), rng.randf_range(-1.0,1.0))

func compareSize(playerSize):
	if size > (playerSize/80 * 100):
		return true
	else:
		return false
