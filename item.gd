extends RigidBody3D

@onready var label : Label3D = %Label
@onready var item_area := %ItemArea
@onready var input_storage := %InputStorage

func _ready() -> void:
	await get_tree().create_timer(5).timeout
	queue_free()
func _process(delta : float) -> void:
	label.visible = item_area == Global.player.targeted_area
	
	if label.visible and !input_storage.is_stopped():
		Global.player.weapon_state_machine.state.switch("Hook")
		visible = false
		call_deferred("queue_free")

func is_near() -> bool:
	return abs((Global.player.global_position - global_position).length())

func _input(event : InputEvent) -> void:
	if event.is_action("Interact"):
		input_storage.start()
