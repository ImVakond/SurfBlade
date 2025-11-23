extends Node3D

@onready var material : ShaderMaterial = %Ocean.get_surface_override_material(0)
var ppos : Vector2 = Vector2(0.5,0.5)

func _ready() -> void:
	Engine.time_scale = 1
	Global.main = self
	Global.player = %Player
	Global.is_ready = true
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	material.set_shader_parameter("paused",false)
	
func _process(_delta : float) -> void:
	ppos = Vector2(0.5,0.5) + Vector2(Global.player.global_position.x,Global.player.global_position.z) / Vector2(5000,5000)
	material.set_shader_parameter("center_position",ppos)

# TODO:
# - Combo
# - Pufferfish enemy
# - Game logo
# - SFX
# - Music
