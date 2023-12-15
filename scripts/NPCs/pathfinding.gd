extends Node

class_name Pathfinding

@onready var body = $".." as EnemyBrain
@onready var npc_movement = $"../NPCMovement" as NPCMovement

@export_group("Navigation")
@export var waypoints_manager: WayPoints
@export var random_navigation: bool = true
var is_moving: bool
var waypoint_index: int = 0
var current_waypoint: Vector3


func start_new_pathing():
	current_waypoint = get_new_waypoint()


func get_new_waypoint() -> Vector3:
	var new_point:Vector3 = Vector3.ZERO
	
	var temp_waypoint = current_waypoint
	
	while temp_waypoint == new_point:
		if random_navigation == true:
			new_point = waypoints_manager.request_random_waypoint()
		else:
			new_point = waypoints_manager.request_waypoint(waypoint_index)
			waypoint_index += 1
			if waypoint_index > waypoints_manager.waypoints.size():
				waypoint_index = 0
	
	current_waypoint = new_point
	npc_movement.set_up_target(current_waypoint)
	return new_point
