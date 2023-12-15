extends NPCState

class_name Idle

@onready var timer = $Timer
@onready var npc_movement: NPCMovement = $"../../NPCMovement" as NPCMovement

@export_group("Configuration")
@export var min_idle_time: int
@export var max_idle_time: int

func enter(_msg : ={}) -> void:
	npc_movement.pause_movement()
	brain.model.idle_animation_play()
	brain.player_detection.start_looking_for_player()
	var rng = RandomNumberGenerator.new()
	var wait_time = rng.randf_range(min_idle_time, max_idle_time)
	
	timer.timeout.connect(on_idle_end)
	timer.wait_time = wait_time
	timer.start()
	print("ñasfeiajñf")


func on_idle_end():
	timer.timeout.disconnect(on_idle_end)
	state_machine.transition_to("Patrol", {})
