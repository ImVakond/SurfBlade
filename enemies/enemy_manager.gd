extends Node3D

enum ENEMIES{
	HARPHISH,
	CHARGER,
	PUFFER
}

const ENEMY_HARPHISH := preload("uid://g0uja46i3wmj")
const ENEMY_CHARGER := preload("uid://ccp4ntv4o8pki")
const ENEMY_PUFFER := preload("uid://dalategwnh1un")
const HARPHISH_BULLET := preload("uid://djsy4i2ta2uo2")
const ITEM := preload("uid://bmywilibhhjqb")

const ENEMYSCENES : Array[PackedScene] = [ENEMY_HARPHISH,ENEMY_CHARGER,ENEMY_PUFFER]

var enemies : Array[Array] = [[],[],[]]

@export var max_fishes : int = 20
@export var max_chargers : int = 10
@export var max_puffers : int = 5

func _ready() -> void:
	for _x in range(max_fishes):
		var enemy : Enemy = await create(ENEMIES.HARPHISH)
		enemy.connect("died",spawn_item_at)
		enemy.connect("shoot",shoot_harpoon)
	for _x in range(max_chargers):
		create(ENEMIES.CHARGER)
	for _x in range(max_puffers):
		create(ENEMIES.PUFFER)

func create(type : int) -> Enemy:
	await get_tree().create_timer(0.05).timeout
	var enemy = ENEMYSCENES[type].instantiate()
	call_deferred("add_child",enemy)
	enemy.set_deferred("position:y",-50)
	enemies[type].append(enemy)
	return enemy

func spawn_item_at(enemy : Enemy) -> void:
	if enemy is not Harphish:
		return
	var item : RigidBody3D = ITEM.instantiate()
	await call_deferred("add_sibling",item)
	item.position = enemy.position
	item.angular_velocity = Vector3(randf_range(-1.0,1.0),randf_range(-1.0,1.0),randf_range(-1.0,1.0))
	item.linear_velocity = (enemy.position - Global.player.global_position).normalized() * Vector3(5,0,5) + Vector3(0,5,0)
	
func shoot_harpoon(pos : Vector3,rot : Vector3) -> void:
	var bullet : Node3D = HARPHISH_BULLET.instantiate()
	await Global.main.call_deferred("add_child",bullet)
	bullet.rotation = rot
	bullet.position = pos + Vector3(0,0.1,0)

func spawn(type : int) -> void:
	for enemy : Enemy in enemies[type]:
		if enemy.can_start():
			enemy.start()
			return

func _on_spawn_timeout() -> void:
	for _i in range(10):
		spawn(ENEMIES.HARPHISH)
	spawn(ENEMIES.CHARGER)
	spawn(ENEMIES.PUFFER) 
