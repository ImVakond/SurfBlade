extends State

var RANDOMNESS : int = 25

func enter(_last : String,_data : Dictionary = {}) -> void:
	owner.position = (Global.player.global_position + Vector3(randf_range(-RANDOMNESS,RANDOMNESS),0,randf_range(-RANDOMNESS,RANDOMNESS))) * Vector3(1,0,1) + Vector3(0,-2,0)
	owner.hook_body.hook_visible = true
func update(delta: float) -> void:
	owner.position.y += 1.5 * delta
	if owner.position.y > 0.2:
		switch(&"Up")
