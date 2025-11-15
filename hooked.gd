extends State

func update(_delta : float) -> void:
	owner.velocity = (owner.active_hook.global_position - owner.global_position).normalized() * 80
	if abs(Vector3(owner.active_hook.global_position - owner.global_position).length()) < 5:
		if owner.active_hook:
			owner.active_hook.queue_free()
		owner.active_hook = null
		owner.velocity /= 2
		switch("Onboard")

func handle_input(event : InputEvent) -> void:
	if event is InputEventMouseMotion:
		owner.cameraholder.rotate_object_local(Vector3(1,0,0),-event.relative.y / 270)
		owner.rotate_object_local(Vector3(0,1,0),-event.relative.x / 270)
