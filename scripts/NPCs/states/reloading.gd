extends NPCState

class_name Reloading

@onready var timer = $Timer
@onready var npc_movement: NPCMovement = $"../../NPCMovement" as NPCMovement

var reload_time: float = 2.0


func enter(_msg : ={}) -> void:
	brain.model.reload_animation_play()
	npc_movement.pause_movement()
	reload_time = brain.reload_time
	timer.timeout.connect(on_reload_end)
	timer.wait_time = reload_time
	timer.start()


func on_reload_end():
	state_machine.transition_to("Hunting", {})


func exit() -> void:
	brain.player_detection.start_looking_for_player()
	timer.timeout.disconnect(on_reload_end)
	npc_movement.resume_movement()
