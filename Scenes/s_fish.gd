extends Area2D

@onready var speed_randomise_timer: Timer = $speedRandomiseTimer

var rng = RandomNumberGenerator.new()
@export var maxSpeed: float
@export var maxSize: float
var speed: float
var dir = Vector2(0,0)
var size

var playerDetected:bool = false

@onready var gameManager = $".."

func _ready() -> void:
	size = rng.randf_range(maxSize/2, maxSize)
	scale = Vector2(size/100, size/100)
	playerDetected = false
	speed = maxSpeed

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		if compareSize(area.get_parent().size):
			area.get_parent().tookDamage()
	
func _process(delta: float) -> void:
	if playerDetected:
		position += (gameManager.player.position - position).normalized() * maxSpeed * delta
		print("chasing player")
	else:
		position += dir * speed * delta
		print("moving randomly")

func compareSize(playerSize):
	if size > (playerSize/80 * 100):
		return true
	else:
		return false

func _on_area_2d_area_entered(area: Area2D) -> void: #Detection rad
	if area.is_in_group("Player"):
		playerDetected = true
		print("detected player")

func _on_speed_randomise_timer_timeout() -> void:
	speed = rng.randf_range(maxSpeed/2, maxSpeed)
	dir = Vector2(rng.randf_range(-1.0,1.0), rng.randf_range(-1.0,1.0))
