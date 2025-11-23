extends Node3D

@onready var scene_change := %SceneChange

func _on_play_pressed():
	await scene_change.exit()
	get_tree().change_scene_to_file("uid://b01axphphb3sk")


func _on_fov_check_box_toggled(toggled_on : bool) -> void:
	Global.settings["FovEffect"] = toggled_on


func _on_motion_blur_check_box_toggled(toggled_on : bool) -> void:
	Global.settings["MotionBlur"] = toggled_on
