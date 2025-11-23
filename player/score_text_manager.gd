extends Control

@export var label_settings : LabelSettings

var labels : Array[Label]
var tweens : Array[Tween]

var idx : int = 0
var format_pos : String = "+%d %s"
var format_neg : String = "%d %s"

const MARGINS : int = 500

func _ready() -> void:
	Global.add_score.connect(spawn)
	for _i in range(10):
		var label : Label = Label.new()
		labels.append(label)
		label.label_settings = label_settings
		label.z_index = 1
		call_deferred("add_child",label)

func spawn(amount : int, text : String) -> void:
	Global.points += amount
	
	var label : Label = labels[idx]
	label.modulate = Color.WHITE
	label.position = Vector2(randi_range(MARGINS,get_viewport().size.x-MARGINS),randi_range(MARGINS,get_viewport().size.y-MARGINS))
	
	if amount < 0:label.text = format_neg % [amount,text]
	else:label.text = format_pos % [amount,text]
	
	var tween = get_tree().create_tween()
	tween.tween_property(label, "position", Vector2.UP * 100, 1).as_relative()
	tween.parallel().tween_property(label, "modulate", Color.TRANSPARENT, 1)
	
	idx = (idx + 1) % 10

	
