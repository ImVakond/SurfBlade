extends State


const HOOK_BODY = preload("uid://bxt06cc0ci6ul")


func enter(last: String, data : Dictionary = {}) -> void:
	owner.crosshair.text = "+"
	owner.controllabel.change({"Right Click" : ""})

func handle_input(event : InputEvent) -> void:
	if event.is_action_pressed("Attack"):
		if !owner.active_hook:
			var hook : CharacterBody3D = HOOK_BODY.instantiate()
			hook.global_rotation = owner.cameraholder.global_rotation
			owner.add_sibling(hook)
			hook.position = owner.position
			owner.active_hook = hook
			hook.connect("time_exceeded",throw_hook)
			hook.connect("hooked",hooked)
		else:
			throw_hook()
	elif event.is_action_pressed("Throw") and !owner.active_hook:
		throw_hook()

func throw_hook() -> void:
	owner.active_hook = null
	switch("Attack")

func hooked() -> void:
	switch("Attack")
	owner.movement_state_machine._transition_to_next_state("Hooked")
