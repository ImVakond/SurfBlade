extends State


func enter(_last : String,_data : Dictionary = {}) -> void:
	owner.gravity.enabled = true
	owner.hurtbox.disabled = false
	owner.velocity *= 0
	owner.velocity.y = 1.5

func update(_delta : float) -> void:
	if owner.global_position.y < 1.5:
		owner.velocity = (Global.player.global_position - owner.global_position).normalized() * Vector3(20,0,20) + Vector3(0,10,0)
	owner.mesh.rotation_degrees += owner.velocity / 5

func exit() -> void:
	owner.gravity.enabled = false
	owner.hurtbox.set_deferred("disabled",true)
