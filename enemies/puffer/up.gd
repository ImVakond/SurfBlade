extends State


func enter(_last : String,_data : Dictionary = {}) -> void:
	owner.velocity = Vector3(randi_range(-15,15),40,randi_range(-15,15))
	owner.gravity.enabled = true

func update(delta : float) -> void:
	pass

func exit() -> void:
	owner.gravity.enabled = false
