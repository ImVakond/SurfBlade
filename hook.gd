extends State

func handle_input(event : InputEvent) -> void:
	if event.is_action_pressed("Attack"):
		print("HOok")
	elif event.is_action_pressed("left"):
		switch("Blade")
