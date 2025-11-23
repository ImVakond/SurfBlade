extends Area3D
# Undertale AU ahh

func _process(_delta : float) -> void:
	global_position = Vector3(1,0,1) * Global.player.global_position
	global_rotation_degrees.y = Global.player.rotation_degrees.y + 90
