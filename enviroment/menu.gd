extends Node3D

@onready var scene_change := %SceneChange

func _on_play_pressed():
	await scene_change.exit()
	var main_scene : PackedScene = load("uid://b01axphphb3sk")
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_packed(main_scene)


func _on_fov_check_box_toggled(toggled_on : bool) -> void:
	Global.settings["FovEffect"] = toggled_on


func _on_motion_blur_check_box_toggled(toggled_on : bool) -> void:
	Global.settings["MotionBlur"] = toggled_on
