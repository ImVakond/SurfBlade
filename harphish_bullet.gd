extends CharacterBody3D

@onready var direction : Vector3 = transform.basis * Vector3(0, 0, -40)

func _process(_delta : float) -> void:
	velocity = direction
	move_and_slide()

func _on_timer_timeout() -> void:
	call_deferred("queue_free")

func _on_hook_area_body_entered(body : Node3D) -> void:
	if body is Player:
		call_deferred("queue_free")
