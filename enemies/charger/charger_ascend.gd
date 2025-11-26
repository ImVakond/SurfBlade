extends State

var RANDOMNESS : int = 25

func enter(_last : String,_data : Dictionary = {}) -> void:
	owner.position = (Global.player.global_position + Vector3(randf_range(-RANDOMNESS,RANDOMNESS),0,randf_range(-RANDOMNESS,RANDOMNESS))) * Vector3(1,0,1) + Vector3(0,-5,0)

func update(delta: float) -> void:
	owner.position.y += 4.5 * delta
	if owner.position.y > 0:
		owner.rotation.y = owner.looker_node.rotation.y
		switch(&"Walk")
