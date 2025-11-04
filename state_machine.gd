extends Node
class_name StateMachine 

@onready var state: State = get_child(0)

func _ready() -> void:
	for state_node: State in find_children("*", "State"):
		state_node.switch_signal.connect(_transition_to_next_state)
	await owner.ready
	state.set_block_signals(false)
	state.enter("")

func _process(delta: float) -> void:
	state._update(delta)

func _input(event : InputEvent) -> void:
	state.handle_input(event)

func _transition_to_next_state(target_state_path: String,data : Dictionary = {}) -> void:
	if not has_node(target_state_path):
		printerr(owner.name + ": Trying to transition to state " + target_state_path + " but it does not exist.")
		return

	var previous_state_path := state.name
	state.exit()
	state.set_block_signals(true)
	state = get_node(target_state_path)
	state.set_block_signals(false)
	state.enter(previous_state_path,data)
