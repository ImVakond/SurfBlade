extends Node3D


const ENEMY_HARPHISH = preload("uid://g0uja46i3wmj")
const ENEMY_CHARGER = preload("uid://ccp4ntv4o8pki")

const HARPHISH_BULLET = preload("uid://djsy4i2ta2uo2")
const ITEM := preload("uid://bmywilibhhjqb")

var enemies1 : Array[CharacterBody3D]
var enemycounter1 : int = 0

var enemies2 : Array[CharacterBody3D]
var enemycounter2 : int = 0

@export var max_fishes : int = 10
@export var max_chargers : int = 3

func _ready() -> void:
	for _x in range(max_fishes):
		await get_tree().create_timer(0.05).timeout
		var enemy = ENEMY_HARPHISH.instantiate()
		add_child(enemy)
		enemy.position = Vector3(0,-50,0)
		enemies1.append(enemy)
		enemy.connect("died",enemy_died)
		enemy.connect("shoot",shoot_harpoon)
	for _y in range(max_chargers):
		await get_tree().create_timer(0.05).timeout
		var enemy = ENEMY_CHARGER.instantiate()
		add_child(enemy)
		enemy.position = Vector3(0,-50,0)
		enemies2.append(enemy)
		enemy.connect("died",enemy_died)
	_on_spawn_timeout()
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
	bullet.position = pos + Vector3(0,0.1,0)

func enemy_died(enemy : Node3D) -> void:
	if enemy is Harphish:
		spawn_item_at(enemy.position)
	enemy.global_position = Vector3(0,-50,0)


func spawn_harpoon() -> void:
	if !max_fishes:
		return
	enemies1[enemycounter1 % max_fishes].start()
	enemycounter1 += 1

func spawn_charger():
	if !max_chargers:
		return
	enemies2[enemycounter2 % max_chargers].start()
	enemycounter2 += 1

func _on_spawn_timeout() -> void:
	for i in range(10):
		spawn_harpoon()
	spawn_charger()
