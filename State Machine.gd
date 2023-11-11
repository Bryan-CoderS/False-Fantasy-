extends Node

const State = preload("res://State.gd")

@export var initial_state: NodePath

var current_state: State
var states: Dictionary = {}

func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition)
			
	if initial_state:
		var initial_state_node = get_node(initial_state)
		if initial_state_node and initial_state_node is State:
			initial_state_node.Enter()
			current_state = initial_state_node

func _process(delta):
	if current_state:
		current_state.Update(delta)    
	
func _physics_process(delta):
	if current_state:
		current_state.Physics_Update(delta)
		
func on_child_transition(state, new_state_name):
	if state != current_state:
		return
	
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
	
	if current_state:
		current_state.Exit()
		
	new_state.Enter()
	
	current_state = new_state
