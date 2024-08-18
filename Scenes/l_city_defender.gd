extends Area2D

@onready var speed_randomise_timer: Timer = $speedRandomiseTimer
@onready var player_detected_timer: Timer = $playerDetectedTimer
@onready var charge_timer: Timer = $chargeTimer
@onready var charging_warning_timer: Timer = $chargingWarningTimer
@onready var proj_timer: Timer = $projTimer


@onready var player_noticed_notif: Sprite2D = $playerNoticedNotif

@onready var proj = preload("res://Scenes/cityDefenderProj.tscn")

var rng = RandomNumberGenerator.new()
@export var maxSpeed: float
@export var maxSize: float
var speed: float
var dir = Vector2(0,0)
var size

var playerDetected:bool = false

@onready var gameManager = $".."

var isPoisoned = false
var isCharging = false

func _ready() -> void:
	size = maxSize
	scale = Vector2(size/100, size/100)
	playerDetected = false
	speed = maxSpeed
	player_noticed_notif.visible = false

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		if compareSize(area.get_parent().size):
			area.get_parent().tookDamage()
	
func _process(delta: float) -> void:
	if isCharging:
		position += dir * maxSpeed * randi_range(6, 10) * delta
		return
	if playerDetected:
		player_noticed_notif.visible = true
		charging_warning_timer.start()
		playerDetected = false
		dir = (gameManager.player.position - position).normalized()
		$detectionRadius.set_collision_mask_value(2, false)
		await charging_warning_timer.timeout
		isCharging = true
		charge_timer.start()
		player_detected_timer.start()
		player_noticed_notif.visible = false
	else:
		if abs(gameManager.player.position - position) > Vector2(2000, 2000):
			position += (gameManager.player.position - position).normalized() * maxSpeed * 4 * delta
		else:
			position += (gameManager.player.position - position).normalized() * maxSpeed * delta

func compareSize(playerSize):
	return true

func _on_area_2d_area_entered(area: Area2D) -> void: #Detection rad
	if area.is_in_group("Player") and !isCharging:
		playerDetected = true
		player_detected_timer.start()

func _on_speed_randomise_timer_timeout() -> void:
	speed = rng.randf_range(maxSpeed/2, maxSpeed)

func _on_player_detected_timer_timeout() -> void:
	playerDetected = false
	player_noticed_notif.visible = false
	$detectionRadius.set_collision_mask_value(2, true)

func tookDamage():
	#if isPoisoned:
		#return
	if size > 60:
		isPoisoned = true
		$AnimationPlayer.play("enemyTooKDamage")
		for i in range(1):
			size -= 5
			$AnimatedSprite2D.scale = Vector2(size/maxSize, size/maxSize)
			$CollisionShape2D.scale = Vector2(size/maxSize, size/maxSize)
			$tookDamageTimer.start()
			await $tookDamageTimer.timeout
		$AnimationPlayer.play("RESET")
		isPoisoned = false

func _on_charge_timer_timeout() -> void:
	isCharging = false

func _on_proj_timer_timeout() -> void:
	var projToSpawn = proj.instantiate()
	projToSpawn.position = position
	dir = (gameManager.player.position - position).normalized()
	projToSpawn.dir = dir
	projToSpawn.size = size
	gameManager.add_child(projToSpawn)
