extends NPCState

@onready var navigation_agent_3d = $"../../NavigationAgent3D"


func enter(_msg : ={}) -> void:
	brain.model.walk_animation_play()
	brain.player_detection.start_looking_for_player()
	#A continuación hay un poco de spaguetti. El componente "WayPoint" solapa su función con
	#la del waypoint manager, basicamente duplicándola de manera innecesaria. Pendiente de pulir
	#en el futuro. Eliminar todo el waypoint manager y usar nodos y grupos para rastrear simples balizas
	#Node3D en el mapa
	brain.waypoint_manager = get_tree().get_nodes_in_group("waypoint_manager").pick_random()
	brain.way_points.waypoints = request_waypoints_for_npc()
	brain.pathfinding.start_new_pathing()
	brain.npc_movement.initialize()
	navigation_agent_3d.navigation_finished.connect(on_end_patrol)


func request_waypoints_for_npc() -> Array[Node3D]:
	return brain.waypoint_manager.request_nodes()


func on_end_patrol():
	state_machine.transition_to("Idle", {})


func exit() -> void:
	navigation_agent_3d.navigation_finished.disconnect(on_end_patrol)
