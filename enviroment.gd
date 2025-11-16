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

@onready var mode : int = 0:
	set(new_mode):
		mode = new_mode
		for sun in suns:
			sun.visible = false
		world_enviroment.environment = enviroments[new_mode]
		suns[new_mode].visible = true
		
func _ready() -> void:
	mode = Global.settings["Time"]
func _input(event : InputEvent) -> void:
	if event.is_action_pressed("1"):
		mode = 0
	if event.is_action_pressed("2"):
		mode = 1
	if event.is_action_pressed("3"):
		mode = 2
