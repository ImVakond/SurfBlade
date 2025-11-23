extends State



func enter(_last: String, _data : Dictionary = {}) -> void:
	owner.crosshair.text = ""
	owner.controllabel.change({"Left Click" : "","Right Click" : ""})
	owner.parrycollision.disabled = false

func handle_input(event : InputEvent) -> void:
	if event.is_action_released("Parry"):
		switch("Attack")
