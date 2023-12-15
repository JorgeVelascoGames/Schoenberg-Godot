extends Node

class_name WayPoints

var waypoints: Array[Node3D]


func initialize(waypoints: Array[Node3D]):
	self.waypoints = waypoints


func request_random_waypoint() -> Vector3:
	return waypoints.pick_random().global_position


func request_waypoint(index: int) -> Vector3:
	var position: Vector3
	
	if index > waypoints.size():
		index = 0
	
	position = waypoints[index].global_position
	
	return position
