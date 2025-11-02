extends CharacterBody3D


const ACCELARATION = 5.0
const JUMP_VELOCITY = 8
const MAX_SPEED = 40.0
var current_speed : float = 0

@onready var cameraholder = %CameraHolder

func _physics_process(delta : float) -> void:
	if Input.is_action_pressed("forward"):
		current_speed = clampf(current_speed+ACCELARATION,0,MAX_SPEED)
	else:
		current_speed = clampf(current_speed-ACCELARATION/3,0,MAX_SPEED)
	var direction = transform.basis * Vector3(0, 0, -current_speed)
	velocity.x = direction.x
	velocity.z = direction.z

func _input(event : InputEvent) -> void:
	if event is InputEventMouseMotion:
		cameraholder.rotate_object_local(Vector3(1,0,0),-event.relative.y / 270)
		rotate_object_local(Vector3(0,1,0),-event.relative.x / 270)
	if event.is_action_pressed("Jump") and (is_on_floor() or global_position.y < 2):
		velocity.y = JUMP_VELOCITY
