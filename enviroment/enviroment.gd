extends Node

@onready var sun_day := %Sun_Day
@onready var sun_set := %Sun_Set
@onready var sun_night := %Moon
@onready var world_enviroment := %WorldEnviroment

const DAYSKY := preload("uid://fgm3o1d0j0ae")
const NIGHTSKY := preload("uid://drbxgywq0qt61")
const SUNSETSKY := preload("uid://cvu64fg4olqe")

var enviroments : Array[Environment] = [DAYSKY,SUNSETSKY,NIGHTSKY]
@onready var suns : Array[DirectionalLight3D] = [sun_day,sun_set,sun_night]


var mode : int = 0:
	set(new_mode):
		mode = new_mode % 3
		for sun in suns:
			sun.visible = false
		world_enviroment.environment = enviroments[mode]
		suns[mode].visible = true
		
func _ready() -> void:
	mode = Global.settings["Time"]
