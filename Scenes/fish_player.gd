extends CharacterBody2D

var speed = 80.0
var size = 100.0
const sizeConsumeMultiplier = 0.05

var dashMultiplier = 3

@onready var anim_player = $AnimationPlayer
@onready var invulTimer = $invulTimer

@onready var gameManager = $".."

var isInvul: bool

var moveDir

var stamina = 100.0

func _ready() -> void:
	updateSizing()
	speed = size * 0.8

func _physics_process(delta: float) -> void:
	handleInput()
	move_and_slide()
	regenStamina()

func handleInput():
	moveDir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = moveDir * speed
	if moveDir.x > 0:
		$Sprite2D.flip_h = false
	elif moveDir.x < 0:
		$Sprite2D.flip_h = true
	if Input.is_action_pressed("ui_accept"):
		dash()

func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		if sizeCompare(area.size):
			size += area.size * sizeConsumeMultiplier
			speed = size * 0.8 #80% of size
			area.queue_free()
			updateSizing()
			anim_player.play("eatSomething")
			gameManager.all_sfx.playEatSound()

func sizeCompare(enemySize):
	if size  * 0.8> (enemySize):
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
	if stamina <= 100:
		stamina += 0.6
