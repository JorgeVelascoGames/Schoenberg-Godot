extends Node
#Deprecated, no loger needed
class_name WaypoitsManager

@export var waypoints: Array[Node3D]


func request_nodes() -> Array[Node3D]:
	return waypoints
