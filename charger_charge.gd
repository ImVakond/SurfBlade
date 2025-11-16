extends State

func enter(_last : String,_data : Dictionary = {}) -> void:
	owner.damager.disabled = false
	owner.rotation.y = owner.looker_node.rotation.y
	owner.velocity = owner.transform.basis * Vector3(0,0,-100) + Vector3(0,10,0)
	await get_tree().create_timer(0.5).timeout
	switch(&"Stun")

func update(delta : float) -> void:
	owner.velocity += owner.get_gravity() * delta * 10
	owner.global_position.y = max(owner.global_position.y,0)

func exit() -> void:
	owner.damager.disabled = true
