extends Node3D


func _ready() -> void:
	Global.main = self
	Global.player = %Player
	Global.is_ready = true

	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
