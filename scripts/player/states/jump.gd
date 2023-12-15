extends PlayerState


func enter(msg = {}):
	player.stamina.set_resource_neutral()
	
	if not player.can_move_on_air:
		player.velocity = Vector3.ZERO #esto hace al jugador caer en picado
	
	if not player.can_jump:
		return
	
	if msg.has("do_jump"):
		player.velocity.y = player.jump_force



func update(delta):
	if player.is_on_floor():
		state_machine.transition_to("Idle", {})


func physics_update(delta: float) -> void:
	if player.can_move_on_air:
		var air_vector
		var velocity_on_jump = player.velocity
		if not player.process_input(delta) == Vector3.ZERO:
			air_vector = lerp(player.velocity, player.process_input(delta) * player.speed, player.air_acceleration * delta)
		else:
			air_vector = lerp(player.velocity, Vector3.ZERO, player.air_acceleration * delta)
		player.velocity = Vector3(air_vector.x, player.velocity.y, air_vector.z)
	
	player.move_and_slide()
