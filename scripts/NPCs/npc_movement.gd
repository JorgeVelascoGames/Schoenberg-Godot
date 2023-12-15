extends Node

class_name NPCMovement

@onready var body = $".." as EnemyBrain
@onready var navigation = $"../NavigationAgent3D" as NavigationAgent3D
@onready var pathfinding = $"../Pathfinding" as Pathfinding
var speed: float = 5
var chase_speed: float = 7
var can_move: bool = true

func initialize():
	navigation.path_desired_distance = 1
	navigation.target_desired_distance = 1
	can_move = true


func set_up_target(new_target):
	navigation.set_target_position(new_target)


func set_up_speed(speed: float, chase_speed: float):
	self.speed = speed
	self.chase_speed = chase_speed


func calculate_speed() -> float:
	if body.state_machine.state is Hunting:
		return chase_speed
	else:
		return speed


func finish_movement():
	navigation.set_target_position(body.global_position)


func pause_movement():
	can_move = false


func resume_movement():
	can_move = true


func _physics_process(delta):	
	if not can_move:
		body.velocity = Vector3.ZERO
		return
	
	var next_path_position = navigation.get_next_path_position()
	var new_velocity = (next_path_position - body.global_position).normalized()
	new_velocity *= calculate_speed()
	
	body.look_at(Vector3(next_path_position.x, body.global_position.y, next_path_position.z))
	
	body.velocity = new_velocity
	body.move_and_slide()
