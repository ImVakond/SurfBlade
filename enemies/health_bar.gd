extends MeshInstance3D

@onready var bar := %Bar

func set_health(health : int, maxhealth : int) -> void:
	bar.max_value = maxhealth
	bar.value = health

func _process(_delta : float):
	look_at(Global.player.global_transform.origin,Vector3(0,-1,0))
	rotation_degrees += Vector3(90,0,0)
