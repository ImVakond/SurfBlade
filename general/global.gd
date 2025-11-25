extends Node

const MAX_COMBO : float = 5.0
const COMBO_RAISE : float = 0.5

signal add_score(amount : int, text : String)

var is_ready : bool = false
var main : Node3D
var player : Node3D

var combo : float = 0:
	set(value):
		combo = clampf(value,0,MAX_COMBO)
		combo_multiplier = 1+ceil(combo) * 0.2

var combo_multiplier : float = 1

var points : int = 0:
	set(value):
		points = max(value,0)
var playerstate : String

var settings : Dictionary = {
	"MotionBlur" : true,
	"FovEffect" : true,
	"Time" : 0
}
