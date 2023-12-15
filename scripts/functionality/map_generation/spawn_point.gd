extends Node3D
class_name SpawnPoint

@export var multiUse: bool = false

var isUsed: bool = false


func use_spawn_point() -> Vector3:
	if not multiUse:
		isUsed = true
	
	return global_position 
