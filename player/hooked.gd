extends State



func enter(from : String, _data : Dictionary = {}) -> void:
	if from != &"Hooked":
		Global.add_score.emit(5,"Hooked")

func update(_delta : float) -> void:
	owner.invincibility.start()
	if !owner.active_hook:
		change()
		return
	if abs(Vector3(owner.active_hook.global_position - owner.global_position).length()) < 5:
		change()
		return
	owner.velocity = (owner.active_hook.global_position - owner.global_position).normalized() * 80

func handle_input(event : InputEvent) -> void:
	if event is InputEventMouseMotion:
		owner.cameraholder.rotate_object_local(Vector3(1,0,0),-event.relative.y / 270)
		owner.rotate_object_local(Vector3(0,1,0),-event.relative.x / 270)

func change() -> void:
	if owner.active_hook:
		owner.active_hook.queue_free()
	owner.active_hook = null
	owner.velocity = owner.velocity/2
	switch(&"Onboard")
	
