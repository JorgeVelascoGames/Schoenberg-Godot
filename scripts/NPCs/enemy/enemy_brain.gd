extends CharacterBody3D

class_name EnemyBrain
@onready var pathfinding = $Pathfinding
@onready var npc_movement = $NPCMovement
@onready var way_points = $WayPoints as WayPoints
@onready var player_detection = $head/PlayerDetection as PlayerDetection
@onready var state_machine = $StateMachine as StateMachine
@onready var model: EnemyModelManager = $Model as EnemyModelManager
@onready var player = get_tree().get_first_node_in_group("player") as Player
@onready var head = $head
@onready var collision_shape_3d = $CollisionShape3D


@export_group("Settings")
@export var patrol_speed: float = 1
@export var hunting_speed: float = 3
@export var hunting_timeout_timer: float = 4
@export var max_detection_range: float = 23
@export var mid_detection_range: float = 15
@export var min_detection_range: float = 3
@export var stun_time: float = 5.0
@export var reload_time: float = 4.0

@export_group("References")
var waypoint_manager: WaypoitsManager


func _ready():
	waypoint_manager = get_tree().get_nodes_in_group("waypoint_manager").pick_random()
	head.get_parent().remove_child(head)
	model.head_attachment.add_child(head)
	player_detection.start_looking_for_player()
	player_detection.player_found.connect(start_chasing_player)
	npc_movement.set_up_speed(patrol_speed, hunting_speed)
	player_detection.set_up_range(max_detection_range, mid_detection_range, min_detection_range)


func start_chasing_player():
	state_machine.transition_to("Hunting", {})


func get_stuned():
	state_machine.transition_to("Stuned", {})


func hit_player():
	state_machine.transition_to("Reloading", {})
