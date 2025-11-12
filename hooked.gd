extends State

func update(delta : float) -> void:
	owner.velocity = (owner.active_hook.global_position - owner.global_position).normalized() * 80
	if abs(Vector3(owner.active_hook.global_position - owner.global_position).length()) < 5:
		if owner.active_hook:
			owner.active_hook.queue_free()
		owner.active_hook = null
		switch("Onboard")
