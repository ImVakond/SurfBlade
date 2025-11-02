extends Area3D
class_name Hitbox

@export var Collider : CollisionShape3D
@export var healthbar : MeshInstance3D
@export var particles : GPUParticles3D

@export var max_health = 5.0

var enemy : bool = true

var health = 1.0:
	set(value):
		health = value
		healthbar.set_health(health,max_health)
		if health <= 0:
			get_parent().queue_free()

func _ready() -> void:
	area_entered.connect(on_area_entered)
	health = max_health

func on_area_entered(area : Area3D) -> void:
	if area.is_in_group("PlayerDamage"):
		health -= 1
		if particles:
			particles.restart()
			particles.emitting = true
