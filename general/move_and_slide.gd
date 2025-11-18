extends Node
class_name MoveAndSlide

@onready var parent : CharacterBody3D = get_parent()
@export var enabled : bool = true:
	set(value):
		enabled = value
		set_physics_process(enabled)

func _physics_process(_delta : float) -> void:
	parent.move_and_slide()
