extends State

var RANDOMNESS : int = 25

var teleported : bool = false

func enter(_last : String,_data : Dictionary = {}) -> void:
	await get_tree().create_timer(randf()).timeout
	owner.position = (Global.player.global_position + Vector3(randf_range(-RANDOMNESS,RANDOMNESS),0,randf_range(-RANDOMNESS,RANDOMNESS))) * Vector3(1,0,1) + Vector3(0,-2,0)
	owner.hook_body.hook_visible = true
	teleported = true
func update(delta: float) -> void:
	if teleported:
		owner.position.y += 1.5 * delta
		owner.look_at(Global.player.global_position)
		if owner.position.y > 0.2:
			switch(&"Up")
			teleported = false
