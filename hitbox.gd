extends Area3D
class_name Hitbox

@export var Collider : CollisionShape3D
@export var healthbar : MeshInstance3D
@export var particles : GPUParticles3D

@export var max_health = 5.0
@export var enemy : bool = true

signal died
signal took_damage

var health = 1.0:
	set(value):
		if health < value:
			took_damage.emit()
		if healthbar:
			healthbar.set_health(value,max_health)
		if value <= 0:
			died.emit()
		health = value
func _ready() -> void:
	area_entered.connect(on_area_entered)
	health = max_health

func on_area_entered(area : Area3D) -> void:
	if area.is_in_group("PlayerDamage") and enemy:
		health -= 1
		if particles:
			particles.restart()
			particles.emitting = true
	elif area.is_in_group("EnemyDamage") and not enemy:
		health -= 1
