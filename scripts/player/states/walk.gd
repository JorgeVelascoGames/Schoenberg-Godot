extends PlayerState

class_name Walk

@onready var health: Health = $"../../Health" as Health


func enter(_msg : ={}) -> void:
	if player.health.current_health_state <= 2:
		player.stamina.set_resource_regenerating()
	else:
		player.stamina.set_resource_neutral()


func update(delta):
	if player.process_input(delta) == Vector3.ZERO:
		state_machine.transition_to("Idle", {})
	
	player._delta += delta
#   no head bumb
#	var cam_bob = floor(abs(player.direction.z) + abs(player.direction.x)) * player._delta * player.camBobSpeed
#	var objCam = player.originCamPos + Vector3.UP * sin(cam_bob) * player.camBobUpDown
	
#	player.camera_3d.position = player.camera_3d.position.lerp(objCam, delta)
	
	if player._delta > 10:
		player._delta = 0
	
	if Input.is_action_just_pressed("interact"):
		player.interact()
	
	if Input.is_action_pressed("action_run", false) and health.current_health_state != health.health_states.fatal:
		state_machine.transition_to("Run", {})
	
	if Input.is_action_pressed("action_crouch"):
		state_machine.transition_to("Crouch", {})
	
	if !player.is_on_floor():
		state_machine.transition_to("Jump", {})
	
	if Input.is_action_just_pressed("do_jump") and player.can_jump:
		state_machine.transition_to("Jump", {do_jump = true})


func physics_update(delta: float) -> void:
	player.velocity = player.velocity.lerp(player.direction * player.get_speed(self), player.accel * delta)
	player.move_and_slide()
