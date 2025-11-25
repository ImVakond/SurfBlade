extends State


func enter(_last : String,_data : Dictionary = {}) -> void:
	owner.shoot.emit(owner.position,owner.rotation)
	owner.hook_body.hook_visible = false
	await get_tree().create_timer(1.0).timeout
	switch(&"Descend")

func update(_delta : float) -> void:
	owner.look_at(Global.player.global_position)
