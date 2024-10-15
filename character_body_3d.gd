extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@onready var ai_controller_3d = $AIController3D

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	#var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	#if direction:
		#velocity.x = direction.x * SPEED
		#velocity.z = direction.z * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		#velocity.z = move_toward(velocity.z, 0, SPEED)

	velocity.x = ai_controller_3d.move.x
	velocity.z = ai_controller_3d.move.z
	move_and_slide()


func _on_target_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	position = Vector3(-3.163,0.68,-0.003)
	ai_controller_3d.reward += 1.0


func _on_walls_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	position = Vector3(-3.163,0.68,-0.003)
	ai_controller_3d.reward -= 1.0
