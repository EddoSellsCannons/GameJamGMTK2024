extends Area2D

@onready var speed_randomise_timer: Timer = $speedRandomiseTimer

var rng = RandomNumberGenerator.new()
@export var maxSpeed: float
@export var maxSize: float
var speed: float
var dir = Vector2(0,0)
var size

@onready var gameManager = $".."

func _ready() -> void:
	size = rng.randf_range(maxSize/2, maxSize)
	scale = Vector2(size/100, size/100)

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		if compareSize(area.get_parent().size):
			area.get_parent().tookDamage()
	
func _process(delta: float) -> void:
	pass

func compareSize(playerSize):
	if size > (playerSize/80 * 100):
		return true
	else:
		return false
