extends CharacterBody3D
class_name Player

const ACCELARATION = 50
const JUMP_VELOCITY = 8
const SPEED = 20.0

@export var FOV_effect : bool = false

@onready var cameraholder := %CameraHolder
@onready var attack_anim := %AttackAnim
@onready var weapon_state_machine: Node = %WeaponStateMachine
@onready var blade_mesh: MeshInstance3D = %BladeMesh
@onready var hook_mesh: MeshInstance3D = %HookMesh
@onready var targeter : RayCast3D = %Targeter
@onready var controllabel : Label = %Controls
@onready var movement_state_machine: StateMachine = %MovementStateMachine
@onready var crosshair := %Crosshair
@onready var parrycollision := %ParryCollision
@onready var camera := %Camera
@onready var knockbackcd := %Knockbackcd

var targeted_area : Area3D = null
var active_hook : CharacterBody3D = null

func _physics_process(_delta : float) -> void:
	if targeter.is_colliding():
		targeted_area = targeter.get_collider()
	else:
		targeted_area = null
	if FOV_effect:
		camera.fov = clampf(70+velocity.length() / 2.0,70,140)
		#if velocity.length() > 20:
	#	cameraholder.position = Vector3(0,0.6,0.2) + Vector3(randf_range(-0.05,0.05),0,randf_range(-0.05,0.05))
func _input(_event : InputEvent) -> void:
	pass

func _on_attack_area_area_entered(area : Area3D) -> void:
	if area is Hitbox and area.enemy and knockbackcd.is_stopped():
		var pitch = cameraholder.global_rotation.x
		var yaw = cameraholder.global_rotation.y
		velocity.y = -sin(pitch) * 50 / 3.0
		velocity +=  50 * Vector3(cos(pitch) * sin(yaw),0,cos(pitch) * cos(yaw))
		knockbackcd.start()
		if movement_state_machine.state.name == "Hook":
			movement_state_machine._transition_to_next_state("Onboardjump")
		
func is_on_floor_or_water() -> bool:
	return is_on_floor() or global_position.y < 1.5
