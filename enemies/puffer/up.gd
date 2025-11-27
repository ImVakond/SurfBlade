extends State

var angular_velocity : Vector3 = Vector3.ZERO

func enter(_last : String,_data : Dictionary = {}) -> void:
	owner.gravity.enabled = true

func update(delta : float) -> void:
	if owner.global_position.y < 1.5:
		owner.velocity = (Global.player.global_position - owner.global_position).normalized() * Vector3(30,0,30) + Vector3(0,15,0)
		angular_velocity = (Global.player.global_position - owner.global_position).normalized() * 5
	owner.mesh.rotation_degrees += owner.velocity / 5

func exit() -> void:
	owner.gravity.enabled = false
