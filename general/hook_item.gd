extends Item

func interacted() -> void:
	Global.player.weapon_state_machine.state.switch(&"Hook")
