extends CharacterBody3D
class_name Enemy

signal died(enemy : Enemy)

@onready var hitbox := %Hitbox
@onready var state_machine : StateMachine = %StateMachine

@export var typename : String = ""
@export var reward : int = 10

func can_start() -> bool:
	return state_machine.state.name == &"Inactive"

func start():
	if can_start():
		visible = true
		state_machine._transition_to_next_state(&"Ascend")
		hitbox.health = hitbox.max_health



func _on_hitbox_died() -> void:
	died.emit(self)
	state_machine._transition_to_next_state(&"Inactive")
	Global.add_score.emit(reward,typename.capitalize())
