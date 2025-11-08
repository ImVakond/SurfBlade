extends CharacterBody3D


const ACCELARATION = 80
const JUMP_VELOCITY = 8
const SPEED = 20.0
var target_speed : float = 0

@onready var cameraholder := %CameraHolder
@onready var attack_anim := %AttackAnim
@onready var weapon_state_machine: Node = %WeaponStateMachine
@onready var blade_mesh: MeshInstance3D = %BladeMesh
@onready var hook_mesh: MeshInstance3D = %HookMesh

func _physics_process(delta : float) -> void:
	if Input.is_action_pressed("forward"):
		target_speed = 1
	elif Input.is_action_pressed("backward"):
		target_speed = -1
	else:
		target_speed = clampf(target_speed-ACCELARATION,0,SPEED)
	var target_direction : Vector3 = transform.basis * Vector3(0, 0, -target_speed * SPEED) + Vector3(0,velocity.y,0)
	velocity = velocity.move_toward(target_direction,ACCELARATION * delta)

func _input(event : InputEvent) -> void:
	if event is InputEventMouseMotion:
		cameraholder.rotate_object_local(Vector3(1,0,0),-event.relative.y / 270)
		rotate_object_local(Vector3(0,1,0),-event.relative.x / 270)
	if event.is_action_pressed("Jump") and (is_on_floor() or global_position.y < 2):
		velocity.y = JUMP_VELOCITY


func _on_attack_area_area_entered(area : Area3D) -> void:
	if area is Hitbox and area.enemy:
		var pitch = cameraholder.global_rotation.x
		var yaw = cameraholder.global_rotation.y
		##TODO: a két hitbox pozíciója helyett a kamera controller szögéből kell kiszámolni a knockbacket
		#velocity += (global_position-area.global_position).normalized() * 50 * Vector3(1,0.2,1)
		velocity +=  50 * Vector3(cos(pitch) * sin(yaw),-sin(pitch) / 5.0,cos(pitch) * cos(yaw))
		
