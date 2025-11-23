extends State


const HOOK_BODY = preload("uid://bxt06cc0ci6ul")


func enter(_last: String, _data : Dictionary = {}) -> void:
	owner.crosshair.text = "+"
	owner.controllabel.change({"Left Click" : "Hook","Right Click" : "","Q" : "Discard Hook"})
	owner.hook_mesh.hook_visible = true
func handle_input(event : InputEvent) -> void:
	if event.is_action_pressed("Attack"):
		if !owner.active_hook:
			var hook : CharacterBody3D = HOOK_BODY.instantiate()
			await owner.call_deferred("add_sibling",hook)
			hook.global_rotation = owner.cameraholder.global_rotation
			hook.position = owner.position
			owner.active_hook = hook
			hook.connect("time_exceeded",throw_hook)
			hook.connect("hooked",hooked)
			owner.hook_mesh.hook_visible = false
	elif event.is_action_pressed("Throw") and !owner.active_hook:
		throw_hook()

func throw_hook() -> void:
	if owner.active_hook: owner.active_hook.set_process(false)
	owner.active_hook = null
	switch(&"Attack")

func hooked() -> void:
	switch(&"Attack")
	owner.movement_state_machine._transition_to_next_state(&"Hooked")
