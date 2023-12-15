extends NPCState

class_name Hunting

@onready var timer: Timer = $Timer


func enter(_msg : ={}) -> void:
	brain.model.run_animation_play()
	brain.npc_movement.initialize()
	timer.set_paused(false)
	timer.wait_time = brain.hunting_timeout_timer
	timer.timeout.connect(on_lost_player)
	timer.start()


func update(_delta: float) -> void:
	brain.npc_movement.set_up_target(brain.player.global_position)
	
	if brain.player_detection.is_player_found():
		timer.start()


func on_lost_player() -> void:
	brain.state_machine.transition_to("Idle", {})


func exit() -> void:
	timer.timeout.disconnect(on_lost_player)
	timer.set_paused(true)
