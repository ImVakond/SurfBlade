extends Node

const MAX_COMBO : float = 5.0
const COMBO_RAISE : float = 3.0

signal add_score(amount : int, text : String)

var is_ready : bool = false
var main : Node3D
var player : Node3D

var points : int = 0:
	set(value):
		points = max(value,0)
var playerstate : String

var settings : Dictionary = {
	"MotionBlur" : true,
	"FovEffect" : true,
	"Time" : 0
}
