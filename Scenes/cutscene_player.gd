extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var allowControls = true

func _physics_process(delta):
	if !allowControls:
		return
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func cut_controls():
	allowControls = false
