extends Node3D
class_name Harphish


signal died(enemy : CharacterBody3D)
signal shoot(pos : Vector3,rot : Vector3)

@onready var state_machine : StateMachine = %StateMachine
@onready var hitbox := %Hitbox

func _process(_delta : float) -> void:
	look_at(Global.player.global_position)

func _on_hitbox_died() -> void:
	emit_signal("died",self)
	state_machine._transition_to_next_state("Inactive")

func start():
	state_machine._transition_to_next_state("Ascend")
	hitbox.health = hitbox.max_health
