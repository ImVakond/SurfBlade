extends Area3D



signal parried

func _on_area_entered(area : Area3D) -> void:
	if area.is_in_group("Shield"):
		parried.emit()
