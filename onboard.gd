extends State

var target_speed : float = 0


func physics_update(delta : float) -> void:
	if Input.is_action_pressed("forward"):
		target_speed = 1
	elif Input.is_action_pressed("backward"):
		target_speed = -1
	else:
		target_speed = clampf(target_speed-owner.ACCELARATION,0,owner.SPEED)
	var target_direction : Vector3 = owner.transform.basis * Vector3(0, 0, -target_speed * owner.SPEED) + Vector3(0,owner.velocity.y,0)
	owner.velocity = owner.velocity.move_toward(target_direction,owner.ACCELARATION * delta)


func handle_input(event : InputEvent) -> void:
	if event.is_action_pressed("Jump") and (owner.is_on_floor() or owner.global_position.y < 2):
		owner.velocity.y = owner.JUMP_VELOCITY
