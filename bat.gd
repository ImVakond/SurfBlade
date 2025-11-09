extends State



func handle_input(event : InputEvent) -> void:
	if event.is_action_pressed("Attack"):
		owner.attack_anim.play("Attack")
