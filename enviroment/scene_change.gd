extends CanvasLayer

signal finished

@export var auto_play_on_enter : bool = true
@onready var effect := %Effect

const time : float = 2
var running : bool = false

func _ready() -> void:
	if auto_play_on_enter:
		await get_tree().create_timer(0.1).timeout
		enter()

func enter() -> void:
	if running:
		await finished
	running = true
	effect.position.y = 0
	var tween = get_tree().create_tween().set_ignore_time_scale(true).set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(effect,"position:y",-1920,time).set_trans(Tween.TRANS_SINE)
	await tween.finished
	running = false
	emit_signal("finished")

func exit() -> void:
	if running:
		await finished
	running = true
	effect.position.y = -1920
	var tween = get_tree().create_tween().set_ignore_time_scale(true).set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(effect,"position:y",-111.0,time).set_trans(Tween.TRANS_BOUNCE)
	await tween.finished
	running = false
	emit_signal("finished")
