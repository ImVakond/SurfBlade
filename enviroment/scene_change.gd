extends CanvasLayer


@export var auto_play_on_enter : bool = true
@onready var effect := %Effect
const time : float = 2

func _ready() -> void:
	if auto_play_on_enter:
		await get_tree().create_timer(0.1).timeout
		enter()

func enter() -> void:
	effect.position.y = 0
	var tween = get_tree().create_tween()
	tween.tween_property(effect,"position:y",-1920,time).set_trans(Tween.TRANS_SINE)
	await tween.finished
	
func exit() -> void:
	effect.position.y = -1920
	var tween = get_tree().create_tween()
	tween.tween_property(effect,"position:y",0,time).set_trans(Tween.TRANS_BOUNCE)
	await tween.finished
