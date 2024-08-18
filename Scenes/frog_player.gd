extends CharacterBody2D

const STAMINA_CAP = 200.0
const SHOOT_COST = 60.0

var speed = 80.0
var size = 100.0
const sizeConsumeMultiplier = 0.1

var dashMultiplier = 3

@onready var anim_player = $AnimationPlayer
@onready var invulTimer = $invulTimer
@onready var gameManager = $".."

var isInvul: bool

var moveDir

var stamina = STAMINA_CAP

@onready var playerProj = preload("res://Scenes/player_proj.tscn")

func _ready() -> void:
	updateSizing()
	speed = (size * 0.8)

func _physics_process(delta: float) -> void:
	handleInput()
	move_and_slide()
	regenStamina()

func handleInput():
	moveDir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = moveDir * speed
	if moveDir.x > 0:
		$Sprite2D.flip_h = false
	else:
		$Sprite2D.flip_h = true
	if Input.is_action_pressed("ui_accept"):
		dash()

func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		if sizeCompare(area.size):
			size += area.maxSize * sizeConsumeMultiplier
			speed = (size * 0.8) #80% of size
			area.queue_free()
			updateSizing()
			anim_player.play("eatSomething")
			gameManager.all_sfx.playEatSound()

func sizeCompare(enemySize):
	if size * 0.8 > (enemySize):
		return true
	else:
		return false

func updateSizing():
	scale = Vector2(size/100, size/100)
	speed = (size * 0.8)
	#$Camera2D.zoom = Vector2(1 - size/1000, 1 - size/1000)

func tookDamage():
	if isInvul:
		return
	if size > 100:
		size *= 0.9
	updateSizing()
	anim_player.play("damageTaken")
	gameManager.all_sfx.playHurtSound()
	isInvul = true
	invulTimer.start()
	await invulTimer.timeout
	anim_player.play("RESET")
	isInvul = false

func dash():
	if stamina > 0:
		velocity += moveDir * speed * dashMultiplier
		stamina -= 1
		
func regenStamina():
	if stamina <= STAMINA_CAP:
		stamina += 0.8

func shootProj(dir):
	if stamina - SHOOT_COST > 0:
		stamina -= SHOOT_COST
		var proj = playerProj.instantiate()
		proj.position = position
		proj.dir = dir
		proj.size = size
		gameManager.add_child(proj)
		gameManager.all_sfx.playShootPoisonSound()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		var mouse_position = get_global_mouse_position()
		var projDir = (mouse_position - global_position).normalized()
		shootProj(projDir)
