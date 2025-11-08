extends Node3D


const ITEM := preload("uid://bmywilibhhjqb")

func _on_hitbox_died() -> void:
	var item : RigidBody3D = ITEM.instantiate()
	call_deferred("add_sibling",item)
	item.global_position = global_position
	item.angular_velocity = Vector3(randf_range(-1.0,1.0),randf_range(-1.0,1.0),randf_range(-1.0,1.0))
	item.linear_velocity = (global_position - Global.player.global_position).normalized() * Vector3(5,0,5) + Vector3(0,5,0)
	call_deferred("queue_free")
	
