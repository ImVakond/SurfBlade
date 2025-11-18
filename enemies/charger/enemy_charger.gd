extends CharacterBody3D

signal died(enemy : Node3D)

@onready var state_machine : StateMachine = %StateMachine
@onready var looker_node : Node3D = Node3D.new()
@onready var charge_cooldown := %ChargeCooldown
@onready var damager := %Damager
@onready var hitbox := %Hitbox

func _ready() -> void:
	call_deferred("add_sibling",looker_node)
func start() -> void:
	if state_machine.state.name == &"Inactive":
		state_machine._transition_to_next_state(&"Ascend")
		hitbox.health = hitbox.max_health

	
func _on_hitbox_took_damage() -> void:
	if state_machine and state_machine.state.name != &"Inactive":
		state_machine._transition_to_next_state(&"Stun")
		

func _on_hitbox_died() -> void:
	if state_machine:
		state_machine._transition_to_next_state(&"Inactive")
		died.emit(self)
func _on_damager_parried() -> void:
	if state_machine and state_machine.state.name != &"Inactive":
		state_machine._transition_to_next_state(&"Stun")
