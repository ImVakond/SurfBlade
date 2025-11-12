extends Node3D


const ITEM := preload("uid://bmywilibhhjqb")
const HARPHISH_BULLET := preload("uid://djsy4i2ta2uo2")
@onready var shoot_cooldown : Timer= %ShootCooldown
var tween = create_tween()

func _ready() -> void:
	await get_tree().create_timer(randi_range(-0.0,0.2)).timeout
	shoot_cooldown.start()

func _process(delta : float) -> void:
	var dir = (Global.player.global_position - global_position).normalized()
	#popipo
func _on_hitbox_died() -> void:
	var item : RigidBody3D = ITEM.instantiate()
	call_deferred("add_sibling",item)
	item.global_position = global_position
	item.angular_velocity = Vector3(randf_range(-1.0,1.0),randf_range(-1.0,1.0),randf_range(-1.0,1.0))
	item.linear_velocity = (global_position - Global.player.global_position).normalized() * Vector3(5,0,5) + Vector3(0,5,0)
	call_deferred("queue_free")
	
func _on_shoot_cooldown_timeout():
	var bullet : Node3D = HARPHISH_BULLET.instantiate()
	bullet.rotation = rotation
	Global.main.add_child(bullet)
	bullet.global_position = global_position
