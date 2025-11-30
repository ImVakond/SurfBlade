extends State

var idx : int = 0

func enter(_last: String, _data : Dictionary = {}) -> void:
	owner.crosshair.text = "o"
	owner.controllabel.change({"Left Click" : "Attack","Right Click" : "Parry","Q" : ""})
	owner.parrycollision.set_deferred("disabled",true)
	owner.attack_anim.play("RESET")
	idx = 0

func handle_input(event : InputEvent) -> void:
	if event.is_action_pressed("Attack") and !owner.attack_anim.is_playing():
		owner.attack_anim.play("Attack"+ str(idx % 2 +1))
		idx += 1
	if event.is_action_pressed("Parry"):
		switch("Parry")
