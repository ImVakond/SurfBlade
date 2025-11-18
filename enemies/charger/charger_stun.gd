extends State


func enter(_last : String,_data : Dictionary = {}) -> void:
	owner.velocity *= Vector3(0,1,0)
	await get_tree().create_timer(2).timeout
	switch(&"Walk")

func update(_delta : float) -> void:
	owner.global_position.y = max(owner.global_position.y,0)
