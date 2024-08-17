extends CharacterBody2D

const SPEED = 100.0
var size = 100

func _physics_process(delta: float) -> void:
	handleInput()
	move_and_slide()

func handleInput():
	var moveDir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = moveDir * SPEED

func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		if sizeCompare(area.size):
			area.queue_free()

func sizeCompare(enemySize):
	if size > (enemySize/80 * 100):
		return true
	else:
		return false
