extends Node3D

var ITEM : Array[PackedScene] = [preload("uid://bmywilibhhjqb"),preload("uid://cmjhrd1wgh3yy")]
var items : Array[Array] = [[],[]]

func _ready() -> void:
	Global.spawn_item.connect(spawn)
	for type : int in range(2):
		for _x in range(10):
			var item : Item = ITEM[type].instantiate()
			await call_deferred("add_child",item)
			item.position.y = -50
			item.despawn.connect(despawn)
			items[type].append(item)

func spawn(type : int, pos : Vector3) -> void:
	for item in items[type]:
		if !item.active:
			item.position = pos
			item.angular_velocity = Vector3(randf_range(-1.0,1.0),randf_range(-1.0,1.0),randf_range(-1.0,1.0))
			item.linear_velocity = -(pos - Global.player.global_position).normalized() * Vector3(5,0,5) + Vector3(0,5,0)
			item.active = true
			return
	printerr("Could not spawn item type ", str(type))

func despawn(item : Item) -> void:
	item.position.y = -50
	item.active = false
