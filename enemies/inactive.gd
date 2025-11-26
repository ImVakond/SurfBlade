extends State

func enter(_last : String,_data : Dictionary = {}) -> void:
	owner.velocity *= 0
	owner.global_position = Vector3(0,-50,0)
	owner.visible = false
	
func exit() -> void:
	owner.visible = true
