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

func _on_weapon_state_machine_switched(_to_state : State) -> void:
	update()

func change(data : Dictionary) -> void:
	for key in data:
		controls[key] = data[key]
	update()
