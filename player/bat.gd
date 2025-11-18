extends State


func enter(_last: String, _data : Dictionary = {}) -> void:
	owner.crosshair.text = "o"
	owner.controllabel.change({"Right Click" : "Parry"})

func handle_input(event : InputEvent) -> void:
	if event.is_action_pressed("Attack") and owner.parrycollision.disabled:
		owner.attack_anim.play("Attack")
	
	if event.is_action_pressed("Parry"):
		owner.parrycollision.disabled = false
	if event.is_action_released("Parry"):
		owner.parrycollision.disabled = true

func exit() -> void:
	owner.parrycollision.disabled = true
	
