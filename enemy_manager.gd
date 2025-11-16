extends Node3D


const ENEMY_HARPHISH = preload("uid://g0uja46i3wmj")
const HARPHISH_BULLET = preload("uid://djsy4i2ta2uo2")
const ITEM := preload("uid://bmywilibhhjqb")

var enemies : Array[CharacterBody3D]
var enemyptr : int = 0

func _ready() -> void:
	for _x in range(50):
		await get_tree().create_timer(0.05).timeout
		var enemy = ENEMY_HARPHISH.instantiate()
		add_child(enemy)
		enemy.position = Vector3(0,-50,0)
		enemies.append(enemy)
		enemy.connect("died",enemy_died)
		enemy.connect("shoot",shoot_harpoon)

func spawn_item_at(pos : Vector3):
	var item : RigidBody3D = ITEM.instantiate()
	await call_deferred("add_sibling",item)
	item.position = pos
	item.angular_velocity = Vector3(randf_range(-1.0,1.0),randf_range(-1.0,1.0),randf_range(-1.0,1.0))
	item.linear_velocity = (pos - Global.player.global_position).normalized() * Vector3(5,0,5) + Vector3(0,5,0)
	
func shoot_harpoon(pos : Vector3,rot : Vector3) -> void:
	var bullet : Node3D = HARPHISH_BULLET.instantiate()
	await Global.main.call_deferred("add_child",bullet)
	bullet.rotation = rot
	bullet.position = pos

func enemy_died(enemy : CharacterBody3D) -> void:
	spawn_item_at(enemy.position)
	enemy.global_position = Vector3(0,-50,0)


func _on_spawn_timeout() -> void:
	#return
	enemies[enemyptr % 49].start()
	enemyptr += 1
