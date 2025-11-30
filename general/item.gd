extends RigidBody3D
class_name Item

signal despawn(item : Item)

var active : bool = false:
	set(value):
		active = value
		set_process(active)
		visible = active
		freeze = !active
@onready var label : Label3D = %Label
@onready var item_area := %ItemArea
@onready var input_storage := %InputStorage

func _process(_delta : float) -> void:
	label.visible = item_area == Global.player.targeted_area
	if label.visible and !input_storage.is_stopped():
		interacted()
		despawn.emit(self)
	if global_position.y <= -2.5:
		despawn.emit(self)

func _input(event : InputEvent) -> void:
	if event.is_action(&"Interact"):
		input_storage.start()

func interacted() -> void:
	pass
