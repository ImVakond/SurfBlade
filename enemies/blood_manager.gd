extends Node3D

const BLOOD_PARTICLES : PackedScene = preload("uid://cayntkbhp2ncw")

var bloods : Array[GPUParticles3D]
var idx : int = 0

func _ready() -> void:
	Global.spawn_blood.connect(spawn)
	for i in range(20):
		var blood = BLOOD_PARTICLES.instantiate()
		bloods.append(blood)
		call_deferred("add_child",blood)
		blood.set_deferred("position:y",-5)
		blood.set_deferred("emitting",true)

func spawn(pos : Vector3) -> void:
	var blood = bloods[idx]
	blood.global_position = Vector3(pos.x,max(pos.y,0.1),pos.z)
	blood.emitting = true
	idx = (idx + 1)%20
