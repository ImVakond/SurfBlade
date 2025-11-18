extends Label


var controls : Dictionary = {
	"Left Click" : "Attack"
}

func update() -> void:
	text = ""
	for key in controls:
		if controls[key]:
			text += key + ": " + controls[key] + "\n"
		else:
			text += "\n"

func _on_weapon_state_machine_switched(to_state : State) -> void:
	var state_name : String = to_state.name
	if state_name == "Attack":
		controls["Q"] = ""
	else:
		controls["Q"] = "Discard " + state_name
	controls["Left Click"] = state_name
	update()

func change(data : Dictionary) -> void:
	for key in data:
		controls[key] = data[key]
	update()
