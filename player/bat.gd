extends State


func enter(_last: String, _data : Dictionary = {}) -> void:
	owner.crosshair.text = "o"
	owner.controllabel.change({"Left Click" : "Attack","Right Click" : "Parry","Q" : ""})
	owner.parrycollision.set_deferred("disabled",true)
func handle_input(event : InputEvent) -> void:
	if event.is_action_pressed("Attack"):
		owner.attack_anim.play("Attack")
	
	if event.is_action_pressed("Parry"):
		switch("Parry")
