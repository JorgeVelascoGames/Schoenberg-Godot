extends Node

class_name Pathfinding

@onready var body = $".." as EnemyBrain
@onready var npc_movement = $"../NPCMovement" as NPCMovement

@export_group("Navigation")
@export var waypoints_node_group_name: String = "Waypoints"
var is_moving: bool
var waypoint_index: int = 0
var current_waypoint: Vector3


func start_new_pathing():
	current_waypoint = get_new_waypoint()


func get_new_waypoint() -> Vector3:
	var new_point:Vector3 = Vector3.ZERO
	
	var temp_waypoint = current_waypoint
	
	while temp_waypoint == new_point:
		new_point = request_random_waypoint()
	
	current_waypoint = new_point
	npc_movement.set_up_target(current_waypoint)
	return new_point


func request_random_waypoint() -> Vector3:
	return get_tree().get_nodes_in_group(waypoints_node_group_name).pick_random()
