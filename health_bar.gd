extends MeshInstance3D

func set_health(health : int, maxhealth : int) -> void:
	%Bar.value = health
	%Bar.max_value = maxhealth

func _process(_delta : float):
	look_at(Global.player.global_transform.origin,Vector3(0,-1,0))
	rotation_degrees += Vector3(90,0,0)
