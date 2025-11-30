extends Area3D
class_name Hitbox

@export var Collider : CollisionShape3D
@export var healthbar : MeshInstance3D
@export var inv_frames : Timer
@export var particles : bool = true
@export var max_health = 5.0
@export var enemy : bool = true
@export var invincible : bool = false
@export var health_bar_visible : bool = false

signal died
signal took_damage
signal knockback(from : Vector3)

var health = 1.0:
	set(value):
		if !inv_frames or inv_frames.is_stopped():
			if health > value:
				if particles:
					Global.spawn_blood.emit(global_position)
				health = min(value,max_health)
				took_damage.emit()
			if healthbar:
				healthbar.set_health(value,max_health)
			if inv_frames:
				inv_frames.start()
			if value <= 0:
				died.emit()
			health = min(value,max_health)


func _ready() -> void:
	area_entered.connect(on_area_entered)
	health = max_health
	#if !health_bar_visible:
	#	visible = false
func on_area_entered(area : Area3D) -> void:
	if invincible:
		return
	if area.is_in_group("PlayerDamage") and enemy:
		health -= 1
	elif area.is_in_group("EnemyDamage") and not enemy:
		health -= 1
		if area.is_in_group("Big"):
			knockback.emit(area.global_position)
