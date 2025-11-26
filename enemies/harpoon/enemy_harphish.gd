extends Enemy
class_name Harphish

signal shoot(pos : Vector3,rot : Vector3)
signal spawn_hook(pos : Vector3)
@onready var hook_body := %HookShooter
