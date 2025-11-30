extends CharacterBody3D

@onready var timer : Timer = %Timer

var active : bool = false:
	set(value):
		active = value
		set_process(active)
		if active:
			timer.start()
		else:
			timer.stop()
			velocity *= 0
			position.y = -50

func _process(_delta : float) -> void:
	velocity = transform.basis * Vector3(0, 0, -40)
	move_and_slide()

func _on_timer_timeout() -> void:
	active = false

func _on_hook_area_body_entered(body : Node3D) -> void:
	if body is Player:
		active = false

func _on_harphish_bullet_area_area_entered(area : Area3D):
	if area.is_in_group("Shield"):
		Global.add_score.emit(5,"Parried")
		active = false
