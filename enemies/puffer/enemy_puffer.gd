extends Enemy


@onready var gravity := %Gravity
@onready var mesh := %Mesh
@onready var hurtbox : CollisionShape3D = %Hurtcollision


func _on_hitbox_took_damage() -> void:
	push_away()

func _on_hurtbox_parried() -> void:
	push_away()

func push_away() -> void:
	velocity = (global_position - Global.player.global_position).normalized() * 20
