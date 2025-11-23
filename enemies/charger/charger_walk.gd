extends State

func enter(_last:String,_data:Dictionary={}) -> void:
	owner.charge_cooldown.start()

func update(delta : float) -> void:
	owner.looker_node.look_at_from_position(owner.global_position,Global.player.global_position)
	owner.rotation.y = lerp_angle(owner.rotation.y,owner.looker_node.rotation.y,5 * delta)
	owner.global_position.y = min(owner.global_position.y,0)
	if get_distance() < 15:
		owner.velocity *= 0
		if owner.charge_cooldown.is_stopped():
			switch(&"Charge")
	elif get_distance() > 100:
		switch(&"Descend")
		owner.velocity *= 0
	else:
		owner.velocity = owner.transform.basis * Vector3(0,0,-5)

func get_distance() -> float:
	return (Global.player.global_position - owner.global_position).length()
