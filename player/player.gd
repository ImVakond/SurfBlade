extends CharacterBody3D
class_name Player

signal wrong_land

const ACCELARATION = 50
const JUMP_VELOCITY = 8
const SPEED = 20.0

@onready var cameraholder : Node3D = %CameraHolder
@onready var attack_anim : AnimationPlayer= %AttackAnim
@onready var weapon_state_machine: Node = %WeaponStateMachine
@onready var hook_mesh : Node3D = %HookMesh
@onready var targeter : RayCast3D = %Targeter
@onready var controllabel : Label = %Controls
@onready var movement_state_machine: StateMachine = %MovementStateMachine
@onready var crosshair : Label = %Crosshair
@onready var parrycollision : CollisionShape3D = %ParryCollision
@onready var camera : Camera3D= %Camera
@onready var knockbackcd : Timer = %Knockbackcd
@onready var motion_blur : Node = %motion_blur
@onready var combo_bar_background := %ComboBarBackground
@onready var combo_bar_counter := %ComboBarCounter
@onready var combo_timer : Timer = %ComboTimer
@onready var headcast : RayCast3D = %HeadCast
@onready var surf_board_holder : Node3D = %SurfBoardHolder
@onready var health_bar : TextureProgressBar = %HealthBar
@onready var hitbox : Hitbox = %Hitbox
@onready var damage_effect : ColorRect = %DamageEffect
@onready var weapons : Node3D = %Weapons
@onready var restart_button := %RestartButton
@onready var active_ui := %ActiveUI
@onready var combo_text := %ComboText
@onready var invincibility : Timer = %Invincibility
@onready var wave_animation : AnimationPlayer = %WaveAnimation
@onready var wave_label : Label = %WaveLabel
@onready var healeffect = %HealEffect

var targeted_area : Area3D = null
var active_hook : CharacterBody3D = null

func _ready() -> void:
	motion_blur.visible = Global.settings["MotionBlur"]
	await get_tree().create_timer(0.1).timeout
	tween_health()
	
func _physics_process(_delta : float) -> void:
	if targeter.is_colliding():
		targeted_area = targeter.get_collider()
	else:
		targeted_area = null
	if Global.settings["FovEffect"]:
		camera.fov = clampf(70+velocity.length() / 2.0,70,140)
	combo_bar_counter.value = Global.combo*10
	combo_bar_background.value = ceil(Global.combo)
	combo_text.text = "x"+str(Global.combo_multiplier)
	combo_text.visible = Global.combo > 0
	Global.playerstate = movement_state_machine.state.name
	hitbox.invincible = !invincibility.is_stopped()
func _on_attack_area_area_entered(area : Area3D) -> void:
	if area is Hitbox and area.enemy and knockbackcd.is_stopped():
		var pitch = cameraholder.global_rotation.x
		var yaw = cameraholder.global_rotation.y
		velocity.y = -sin(pitch) * 50 / 3.0
		velocity +=  50 * Vector3(cos(pitch) * sin(yaw),0,cos(pitch) * cos(yaw))
		knockbackcd.start()
		if movement_state_machine.state.name == &"Hook":
			movement_state_machine._transition_to_next_state(&"Onboardjump")
		Global.combo += Global.COMBO_RAISE
		combo_timer.start()

func is_on_floor_or_water() -> bool:
	return is_on_floor() or global_position.y < 1.5

func _on_combo_timer_timeout() -> void:
	Global.combo -= 0.1

func heal() -> void:
	Global.add_score.emit(5,"Healed")
	healeffect.emitting = true
	hitbox.health += 1
	tween_health()

func _on_hitbox_took_damage() -> void:
	Global.add_score.emit(-5,"Hit")
	Global.combo -= 0.5
	tween_health()

func tween_health() -> void:
	var tween : Tween = get_tree().create_tween()
	tween.tween_property(health_bar,"value",hitbox.health*10,0.5)


func _on_hitbox_died() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	movement_state_machine._transition_to_next_state("Inactive")
	weapons.visible = false

	var tween : Tween = get_tree().create_tween()
	#tween.tween_property(Engine,"time_scale",0,1).set_trans(Tween.TRANS_EXPO)
	tween.parallel().tween_property(damage_effect,"modulate",Color.WHITE,0.5).set_trans(Tween.TRANS_EXPO)
	tween.parallel().tween_property(restart_button,"position:y",800,1).set_trans(Tween.TRANS_EXPO)
	await tween.finished
	tween.kill()
	Engine.time_scale = 0
	get_tree().paused = true
	damage_effect.modulate = Color.WHITE
	active_ui.visible = false
	
func _on_hitbox_knockback(from : Vector3) -> void:
	velocity = (global_position - from).normalized() * Vector3(50,0,50) + Vector3(0,velocity.y,0)

func wave_changed(to : int) -> void:
	wave_animation.play("change_wave")
	await wave_animation.animation_finished
	await get_tree().create_timer(0.5).timeout
	wave_label.text = "Wave " + str(to+1)
	wave_animation.play("leave")
