extends Area3D

signal parried

@onready var damage_collider := %DamageCollider
@export var disabled : bool = true:
	set(value):
		disabled = value
		damage_collider.set_deferred("disabled",value)
		visible = !disabled
	
func _on_area_entered(area : Area3D) -> void:
	if area.is_in_group("Shield") or area.is_in_group("PlayerDamage"):
		disabled = true
		Global.add_score.emit(5,"Parried")
		emit_signal("parried")
