extends Node
class_name State

signal switch_signal(state : State,data : Dictionary)

func _ready() -> void:
	set_block_signals(true)

func update(_delta: float) -> void:
	pass

func enter(_previous_state_path: String,_data := {}) -> void:
	pass

func exit() -> void:
	pass

func physics_update(_delta : float) -> void:
	pass

func switch(to_state : String,data : Dictionary = {}) -> void:
	switch_signal.emit(to_state,data)
func handle_input(_input : InputEvent) -> void:
	pass
func exit_on_area() -> void:
	pass
