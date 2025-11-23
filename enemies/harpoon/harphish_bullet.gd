extends CharacterBody3D


func _process(_delta : float) -> void:
	velocity = transform.basis * Vector3(0, 0, -40)
	move_and_slide()

func _on_timer_timeout() -> void:
	call_deferred("queue_free")

func _on_hook_area_body_entered(body : Node3D) -> void:
	if body is Player and is_processing():
		call_deferred("queue_free")

func _on_harphish_bullet_area_area_entered(area : Area3D):
	if area.is_in_group("Shield"):
		Global.spawn_text.emit(5,"Parried")
		set_process(false)
		call_deferred("queue_free")
