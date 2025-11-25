extends Enemy
class_name Charger

@onready var looker_node : Node3D = Node3D.new()
@onready var charge_cooldown := %ChargeCooldown
@onready var damager := %Damager

func _ready() -> void:
	call_deferred("add_sibling",looker_node)

func _on_damager_parried() -> void:
	if state_machine and state_machine.state.name != &"Inactive":
		state_machine._transition_to_next_state(&"Stun")
