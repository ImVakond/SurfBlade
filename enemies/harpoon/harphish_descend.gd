extends State

func update(delta: float) -> void:
	owner.position.y -= 0.5 * delta
	owner.look_at(Global.player.global_position)
	if owner.position.y < -0.5:
		switch(&"Ascend")
