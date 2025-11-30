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
const ENEMYSCENES : Array[PackedScene] = [ENEMY_HARPHISH,ENEMY_CHARGER,ENEMY_PUFFER]

signal wave_changed(to : int)

var enemies : Array[Array] = [[],[],[]]
var bullets : Array[CharacterBody3D]

var alive : int = 0:
	set(value):
		alive = value
		if alive <= 0:
			current_wave += 1
			wave_changed.emit(current_wave)
			if current_wave <= 4:
				spawn_wave(tutorial[current_wave])
			else:
				spawn_wave(endless.pick_random())
var current_wave : int = 0
var pity : int = 0
@export var max_fishes : int = 20
@export var max_chargers : int = 10
@export var max_puffers : int = 5

@export var tutorial : Array[Wave]
@export var endless : Array[Wave]

func _ready() -> void:
	for _x in range(max_fishes):
		var enemy : Enemy = await create(ENEMIES.HARPHISH)
		enemy.connect("shoot",shoot_harpoon)
	for _x in range(max_chargers):
		create(ENEMIES.CHARGER)
	for _x in range(max_puffers):
		create(ENEMIES.PUFFER)
	for _x in range(40):
		var bullet : CharacterBody3D = HARPHISH_BULLET.instantiate()
		call_deferred("add_child",bullet)
		bullets.append(bullet)
	
	spawn_wave(tutorial[0])
	wave_changed.emit(0)

func create(type : int) -> Enemy:
	await get_tree().create_timer(0.05).timeout
	var enemy = ENEMYSCENES[type].instantiate()
	call_deferred("add_child",enemy)
	enemy.set_deferred("position:y",-50)
	enemies[type].append(enemy)
	enemy.connect("died",enemy_died)
	return enemy

func enemy_died(enemy : Enemy) -> void:
	alive -= 1
	spawn_item_at(enemy)

func spawn_item_at(enemy : Enemy) -> void:
	if enemy is Harphish:
		Global.spawn_item.emit(Global.ITEMS.HARPOON,enemy.position)
	elif randi_range(1,10) == 1 or pity >= 5:
		pity = 0
		Global.spawn_item.emit(Global.ITEMS.HEAL,enemy.position)
	else:
		pity += 1
func shoot_harpoon(pos : Vector3,rot : Vector3) -> void:
	for bullet in bullets:
		if !bullet.active:
			bullet.rotation = rot
			bullet.position = pos + Vector3(0,0.1,0)
			bullet.active = true
			return
	printerr("Could not spawn bullet")

func spawn(type : int) -> void:
	for enemy : Enemy in enemies[type]:
		if enemy.can_start():
			enemy.start()
			return
	printerr("Could not spawn enemy type", type)
	alive -= 1

func spawn_wave(wave : Wave) -> void:
	await get_tree().create_timer(2).timeout
	alive = wave.harphish_amount + wave.charger_amount + wave.puffer_amount
	for _a in range(wave.harphish_amount):
		spawn(ENEMIES.HARPHISH)
	for _b in range(wave.charger_amount):
		spawn(ENEMIES.CHARGER)
	for _c in range(wave.puffer_amount):
		spawn(ENEMIES.PUFFER)
