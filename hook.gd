extends State

var active_hook : CharacterBody3D = null

const HOOK_BODY = preload("uid://bxt06cc0ci6ul")


func _physics_process(_delta : float) -> void:
	if active_hook and active_hook.hooked:
		owner.velocity = (active_hook.global_position - owner.global_position).normalized() * 80
		if abs(Vector3(active_hook.global_position - owner.global_position).length()) < 5:
			get_used_up()
	
func handle_input(event : InputEvent) -> void:
	if event.is_action_pressed("Attack"):
		if !active_hook:
			var hook : CharacterBody3D = HOOK_BODY.instantiate()
			hook.global_rotation = owner.cameraholder.global_rotation
			owner.add_sibling(hook)
			hook.position = owner.position
			active_hook = hook
			hook.connect("time_exceeded",get_used_up)
		else:
			get_used_up()
	elif event.is_action_pressed("Throw") and !active_hook:
		get_used_up()

func get_used_up() -> void:
	if active_hook:
		active_hook.queue_free()
		active_hook = null
	switch("Attack")
