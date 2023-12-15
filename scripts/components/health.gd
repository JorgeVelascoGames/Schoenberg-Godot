extends Node

class_name Health

@onready var label: Label = $CanvasLayer/Label
@onready var state_machine: Node = $"../StateMachine"

signal lost_health_state

enum health_states {healthy, injured, wounded, fatal}

@export_group("Initial state")
@export var current_health_state : health_states = health_states.healthy


func _ready() -> void:
	label.text = str(current_health_state)


func get_hit():
	if current_health_state == 3:
		#die
		return
	
	current_health_state += 1
	lost_health_state.emit()
	
	label.text = str(current_health_state)


func _on_hurt_box_body_entered(body: Node3D) -> void:
	if not body is EnemyBrain:
		return
	if state_machine.state is Frenzy:
		return
	if body.state_machine.state is Stuned:
		return
	if body.state_machine.state is Reloading:
		return
	
	body.hit_player()
	get_hit()


func heal():
	if current_health_state == 0:
		return
	
	current_health_state -= 1
	
	label.text = str(current_health_state)
