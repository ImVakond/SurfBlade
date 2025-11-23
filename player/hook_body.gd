extends CharacterBody3D

signal time_exceeded
signal hooked
@onready var direction : Vector3 = transform.basis * Vector3(0, 0, -80)

func _process(_delta : float) -> void:
	velocity = direction
	move_and_slide()

func _on_timer_timeout() -> void:
	if is_processing():
		emit_signal("time_exceeded")
	call_deferred("queue_free")

func _on_hook_area_body_entered(body : Node3D):
	if body is not Player:
		set_process(false)
		emit_signal("hooked")
		
