extends Node

const MAX_COMBO : float = 5.0
const COMBO_RAISE : float = 3.0

var is_ready : bool = false
var main : Node3D
var player : Node3D
var points : int = 0

var settings : Dictionary = {
	"MotionBlur" : true,
	"FovEffect" : true,
	"Time" : 0
}
