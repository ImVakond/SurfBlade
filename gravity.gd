extends Node
class_name Gravity

@onready var parent : CharacterBody3D = get_parent()
@export var enabled : bool = true:
	set(value):
		enabled = value
		set_physics_process(enabled)

func _physics_process(delta : float) -> void:
	if parent.global_position.y > 1 or parent.is_on_floor():
		parent.velocity += parent.get_gravity() * delta
		parent.global_position.y = max(parent.global_position.y,1)
	else:
		parent.velocity.y = max(parent.velocity.y,0)
