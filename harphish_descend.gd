extends State

func enter(_last : String,_data : Dictionary = {}) -> void:
	await get_tree().create_timer(3).timeout
	switch("Ascend")

func update(delta: float) -> void:
	owner.position.y -= 0.5 *delta

	
