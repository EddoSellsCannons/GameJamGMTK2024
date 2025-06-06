extends CharacterBody2D

var speed = 80.0
var size = 100.0
const sizeConsumeMultiplier = 0.15

@onready var anim_player = $AnimationPlayer
@onready var invulTimer = $invulTimer

@onready var gameManager = $".."

var isInvul: bool

func _ready() -> void:
	updateSizing()

func _physics_process(delta: float) -> void:
	handleInput()
	move_and_slide()

func handleInput():
	var moveDir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = moveDir * speed

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
	if size  * 0.8 > (enemySize):
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
	
