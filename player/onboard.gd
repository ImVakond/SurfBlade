extends State

var target_speed : Vector2

func enter(_from : String, _data : Dictionary = {}) -> void:
	owner.controllabel.change({
		"W" : "Forward",
		"S" : "Backward",
		"A" : "Left",
		"D" : "Right",
		"Space" : "Jump"
	})
	if owner.headcast.is_colliding():
		owner.wrong_land.emit()
		Global.add_score.emit(-20,"Busted Landing")
		owner.hitbox.health -= 1
		owner.cameraholder.rotation_degrees.x = clampf(owner.cameraholder.rotation_degrees.x,-80,90)

	owner.surf_board_holder.rotation_degrees = Vector3(0,0,0)
	owner.surf_board_holder.get_child(0).position.y = -0.6
func physics_update(delta : float) -> void:
	if Input.is_action_pressed("forward"):
		target_speed.x = 1
	elif Input.is_action_pressed("backward"):
		target_speed.x = -1
	else:
		target_speed.x = clampf(target_speed.x-owner.ACCELARATION,0,owner.SPEED)
	if Input.is_action_pressed("left"):
		target_speed.y = 1
	elif Input.is_action_pressed("right"):
		target_speed.y = -1
	else:
		target_speed.y = clampf(target_speed.y-owner.ACCELARATION,0,owner.SPEED)
	
	var target_direction : Vector3 = owner.transform.basis * Vector3(-target_speed.y*10, 0, -target_speed.x * owner.SPEED) + Vector3(0,owner.velocity.y,0)
	owner.velocity = owner.velocity.move_toward(target_direction,owner.ACCELARATION * delta)

	if !owner.is_on_floor_or_water():
		switch(&"Onboardjump")

func handle_input(event : InputEvent) -> void:
	if event.is_action_pressed("Jump"):
		owner.velocity.y = owner.JUMP_VELOCITY
	if event is InputEventMouseMotion:
		owner.cameraholder.rotate_object_local(Vector3(1,0,0),-event.relative.y / 270)
		owner.rotate_object_local(Vector3(0,1,0),-event.relative.x / 270)
		owner.cameraholder.rotation_degrees.x = clampf(owner.cameraholder.rotation_degrees.x,-80,90)
