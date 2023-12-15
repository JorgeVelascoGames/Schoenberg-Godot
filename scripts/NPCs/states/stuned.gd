extends NPCState

class_name Stuned

@onready var timer = $Timer
@onready var npc_movement: NPCMovement = $"../../NPCMovement" as NPCMovement

@export_group("Configuration")
@export var stun_time: float = 3.0

func enter(_msg : ={}) -> void:
	brain.model.stun_animation_play()
	var rng = RandomNumberGenerator.new()
	npc_movement.pause_movement()
	brain.player_detection.looking_for_player = false
	stun_time = brain.stun_time
	timer.timeout.connect(on_stun_end)
	timer.wait_time = stun_time
	timer.start()


func on_stun_end():
	state_machine.transition_to("Idle", {})


func exit() -> void:
	npc_movement.resume_movement()
	brain.player_detection.start_looking_for_player()
	timer.timeout.disconnect(on_stun_end)
