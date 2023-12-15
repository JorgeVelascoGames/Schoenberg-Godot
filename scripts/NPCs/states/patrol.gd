extends NPCState

@onready var navigation_agent_3d = $"../../NavigationAgent3D"


func enter(_msg : ={}) -> void:
	brain.model.walk_animation_play()
	brain.player_detection.start_looking_for_player()
	brain.pathfinding.start_new_pathing()
	brain.npc_movement.initialize()
	navigation_agent_3d.navigation_finished.connect(on_end_patrol)


func on_end_patrol():
	state_machine.transition_to("Idle", {})


func exit() -> void:
	navigation_agent_3d.navigation_finished.disconnect(on_end_patrol)
