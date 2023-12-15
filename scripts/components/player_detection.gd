extends Node3D

class_name PlayerDetection

@onready var mesh_instance_3d = $MeshInstance3D
@onready var ray_cast_3d = $RayCast3D as RayCast3D
@onready var high_range = $HighRange/CollisionShape3D as CollisionShape3D
@onready var mid_range = $MidRange/CollisionShape3D as CollisionShape3D
@onready var low_range = $LowRange/CollisionShape3D as CollisionShape3D

signal player_found

@export_group("Detection settings")
@export var vision_cone_arc: int = 90
@export var looking_for_player: bool = true
var player_detected: bool = false
var player_on_range
enum player_danger_level {low, mid, high}
var current_danger_level = player_danger_level.low

@export_group("Debug")
@export var visual_indicator: bool = false

@onready var player = get_tree().get_first_node_in_group("player") as Player


func _ready():
	if player == null:
		looking_for_player = false
	mesh_instance_3d.hide()


func set_up_range(max_range: float, mid_range: float, min_range: float):
	high_range.shape.radius = max_range
	self.mid_range.shape.radius = mid_range
	low_range.shape.radius = min_range


func _process(delta):
	if not looking_for_player:
		return
	
	if is_player_found():
		looking_for_player = false
		player_found.emit()
	
	if visual_indicator == false:
		return
	
	if is_player_found():
		mesh_instance_3d.show()
	else:
		mesh_instance_3d.hide()


func start_looking_for_player():
	looking_for_player = true


func is_player_found() -> bool:
	if player_on_range == false:
		return false
	
	match(current_danger_level):
		player_danger_level.low:#A maxima distancia solo puede verte, no oirte
			if is_player_on_sight():
				return true
		player_danger_level.mid:
			if is_player_on_sight():
				return true
			if player.state_machine.state is Run:
				return true
		player_danger_level.high:
			if is_player_on_sight():
				return true
			if not player.state_machine.state is Crouch:
				return true
	return false


func is_player_on_sight() -> bool:
	if not looking_for_player:
		return false
	#is player on sight angle?
	var point = player.global_position
	var forward = -get_global_transform().basis.z
	var direction_to_point: Vector3 = point - global_position
	var angle = rad_to_deg(direction_to_point.angle_to(forward))
	
	if angle > vision_cone_arc/2:
		return false
	#Is player visible?
	ray_cast_3d.enabled = true
	
	if is_player_visible() == false:
		return false
	
	return true


func is_player_visible() -> bool:
	ray_cast_3d.target_position = to_local(player.global_position + Vector3(0, 0.2, 0))
	var collider = ray_cast_3d.get_collider()
	
	if collider is Player:
		return true
	
	return false


func _on_high_range_body_entered(body):
	if body is Player:
		player_on_range = true
		current_danger_level = player_danger_level.low


func _on_high_range_body_exited(body):
	if body is Player:
		player_on_range = false


func _on_mid_range_body_entered(body):
	if body is Player:
		current_danger_level = player_danger_level.mid


func _on_mid_range_body_exited(body):
	if body is Player:
		current_danger_level = player_danger_level.low


func _on_low_range_body_entered(body):
	if body is Player:
		current_danger_level = player_danger_level.high


func _on_low_range_body_exited(body):
	if body is Player:
		current_danger_level = player_danger_level.mid
