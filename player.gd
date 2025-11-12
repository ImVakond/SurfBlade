extends CharacterBody3D
class_name Player

const ACCELARATION = 50
const JUMP_VELOCITY = 8
const SPEED = 20.0

@onready var cameraholder := %CameraHolder
@onready var attack_anim := %AttackAnim
@onready var weapon_state_machine: Node = %WeaponStateMachine
@onready var blade_mesh: MeshInstance3D = %BladeMesh
@onready var hook_mesh: MeshInstance3D = %HookMesh
@onready var targeter : RayCast3D = %Targeter
@onready var controllabel : Label = %Controls
@onready var movement_state_machine: Node = %MovementStateMachine
@onready var crosshair := %Crosshair
@onready var parrycollision := %ParryCollision

var targeted_area : Area3D = null
var active_hook : CharacterBody3D = null

func _physics_process(_delta : float) -> void:
	if targeter.is_colliding():
		targeted_area = targeter.get_collider()
	else:
		targeted_area = null
func _input(event : InputEvent) -> void:
	pass

func _on_attack_area_area_entered(area : Area3D) -> void:
	if area is Hitbox and area.enemy:
		var pitch = cameraholder.global_rotation.x
		var yaw = cameraholder.global_rotation.y
		velocity.y = -sin(pitch) * 50 / 3.0
		velocity +=  50 * Vector3(cos(pitch) * sin(yaw),0,cos(pitch) * cos(yaw))
		
func is_on_floor_or_water() -> bool:
	return is_on_floor() or global_position.y < 1.5
