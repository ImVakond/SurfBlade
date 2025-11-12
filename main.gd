extends Node3D

const BASIC_ENEMY = preload("uid://g0uja46i3wmj")
func _ready() -> void:
	Global.main = self
	Global.player = %Player
	Global.is_ready = true

	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	for _i in range(40):
		continue
		var enemy = BASIC_ENEMY.instantiate()
		call_deferred("add_child",enemy)
		await get_tree().create_timer(0.1).timeout
		enemy.global_position = Vector3(randi_range(-50,50),1,randi_range(-50,50))
