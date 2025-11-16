extends State


func enter(_last : String,_data : Dictionary = {}) -> void:
	owner.shoot.emit(owner.position,owner.rotation)
	await get_tree().create_timer(1.0).timeout
	switch(&"Descend")
