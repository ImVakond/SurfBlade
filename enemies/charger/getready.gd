extends State


func enter(_last:String,_data:Dictionary={}) -> void:
	owner.velocity *= 0
	await get_tree().create_timer(0.2).timeout
	switch(&"Charge")
