extends CanvasLayer


@export var auto_play_on_enter : bool = true
@onready var effect := %Effect
const time : float = 0.5

func _ready() -> void:
	enter()

func enter() -> void:
	effect.modulate = Color.WHITE
	var tween = get_tree().create_tween()
	tween.tween_property(effect,"modulate",Color.TRANSPARENT,time)
	await tween.finished
	
func exit() -> void:
	effect.modulate = Color.TRANSPARENT
	var tween = get_tree().create_tween()
	tween.tween_property(effect,"modulate",Color.WHITE,time)
	await tween.finished
	
func in_and_out() -> void:
	await exit()
	await enter()
