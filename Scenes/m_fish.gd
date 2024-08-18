extends Area2D

@onready var speed_randomise_timer: Timer = $speedRandomiseTimer
@onready var player_detected_timer: Timer = $playerDetectedTimer

@onready var player_noticed_notif: Sprite2D = $AnimatedSprite2D/playerNoticedNotif


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
	player_noticed_notif.visible = false

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		if compareSize(area.get_parent().size):
			area.get_parent().tookDamage()
	
func _process(delta: float) -> void:
	if playerDetected:
		if gameManager.player.size < size * 0.8:
			position += (gameManager.player.position - position).normalized() * maxSpeed * delta
		elif gameManager.player.size  * 0.8 > size:
			position -= (gameManager.player.position - position).normalized() * maxSpeed * delta
		else:
			position += dir * speed * delta
		player_noticed_notif.visible = true
	else:
		position += dir * speed * delta
	if dir.x > 0:
		$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.flip_h = true

func compareSize(playerSize):
	if size  * 0.8 > (playerSize):
		return true
	else:
		return false

func _on_area_2d_area_entered(area: Area2D) -> void: #Detection rad
	if area.is_in_group("Player"):
		playerDetected = true
		player_detected_timer.start()

func _on_speed_randomise_timer_timeout() -> void:
	speed = rng.randf_range(maxSpeed/2, maxSpeed)
	dir = Vector2(rng.randf_range(-1.0,1.0), rng.randf_range(-1.0,1.0))

func _on_player_detected_timer_timeout() -> void:
	playerDetected = false
	player_noticed_notif.visible = false
