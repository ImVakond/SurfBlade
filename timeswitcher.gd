extends Button

const SUN = preload("uid://h450rujvix5l")
const SUNSET = preload("uid://qvnrcx2swmwa")
const MOON = preload("uid://b772m8a8o34hr")

var icons = [SUN,SUNSET,MOON]

@export var enviroment : Node

func _on_pressed() -> void:
	enviroment.mode += 1
	Global.settings["Time"] = enviroment.mode
	icon = icons[enviroment.mode]
