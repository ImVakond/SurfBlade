extends State


func update(delta:float) -> void:
	owner.position.y += 4.5 * delta
	if owner.position.y > 0:
		switch(&"Up")
