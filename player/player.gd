extends CharacterBody3D
class_name Player

const ACCELARATION = 50
const JUMP_VELOCITY = 8
const SPEED = 20.0

@onready var cameraholder : Node3D = %CameraHolder
@onready var attack_anim : AnimationPlayer= %AttackAnim
@onready var weapon_state_machine: Node = %WeaponStateMachine
@onready var blade_mesh: MeshInstance3D = %BladeMesh
@onready var hook_mesh: Node3D = %HookMesh
@onready var targeter : RayCast3D = %Targeter
@onready var controllabel : Label = %Controls
@onready var movement_state_machine: StateMachine = %MovementStateMachine
@onready var crosshair : Label = %Crosshair
@onready var parrycollision : CollisionShape3D = %ParryCollision
@onready var camera : Camera3D= %Camera
@onready var knockbackcd : Timer = %Knockbackcd
@onready var motion_blur : Node = %motion_blur
@onready var combo_bar : TextureProgressBar = %ComboBar
@onready var combo_timer : Timer = %ComboTimer

var targeted_area : Area3D = null
var active_hook : CharacterBody3D = null

func _ready() -> void:
	motion_blur.visible = Global.settings["MotionBlur"]
	combo_timer.wait_time = Global.MAX_COMBO
	combo_bar.max_value = Global.MAX_COMBO*10
func _physics_process(_delta : float) -> void:
	if targeter.is_colliding():
		targeted_area = targeter.get_collider()
	else:
		targeted_area = null
	if Global.settings["FovEffect"]:
		camera.fov = clampf(70+velocity.length() / 2.0,70,140)
	combo_bar.value = combo_timer.time_left * 10
func _on_attack_area_area_entered(area : Area3D) -> void:
	if area is Hitbox and area.enemy and knockbackcd.is_stopped():
		var pitch = cameraholder.global_rotation.x
		var yaw = cameraholder.global_rotation.y
		velocity.y = -sin(pitch) * 50 / 3.0
		velocity +=  50 * Vector3(cos(pitch) * sin(yaw),0,cos(pitch) * cos(yaw))
		knockbackcd.start()
		if movement_state_machine.state.name == &"Hook":
			movement_state_machine._transition_to_next_state(&"Onboardjump")
		combo_timer.wait_time = min(combo_timer.time_left + Global.COMBO_RAISE,Global.MAX_COMBO)
		combo_timer.start()

func is_on_floor_or_water() -> bool:
	return is_on_floor() or global_position.y < 1.5

func _on_combo_timer_timeout() -> void:
	Global.points = 0
