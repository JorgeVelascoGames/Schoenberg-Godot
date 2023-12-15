extends PlayerState

class_name Frenzy

@onready var timer: Timer = $Timer


func enter(msg = {}):
	player.stamina.set_resource_neutral()
	player.stamina.fill_resource()
	player.set_collision_mask_value(2, false)
	timer.wait_time = player.frenzy_duration
	timer.timeout.connect(finish_frenzy)
	timer.start()


func update(delta):
	player._delta += delta
	
	var cam_bob = floor(abs(player.direction.z) + abs(player.direction.x)) * player._delta * player.camBobSpeed
	var objCam = player.originCamPos + Vector3.UP * sin(cam_bob) * player.camBobUpDown * 3
	
	player.camera_3d.position = player.camera_3d.position.lerp(objCam, delta)
	
	if player._delta > 10:
		player._delta = 0
	
	if Input.is_action_just_pressed("interact"):
		player.interact()
		
	if Input.is_action_just_pressed("do_jump") and player.can_jump:
		state_machine.transition_to("Jump", {do_jump = true})


func physics_update(delta):
	player.velocity = player.velocity.lerp(player.direction * player.get_speed(self), player.accel * delta)
	player.move_and_slide()


func finish_frenzy():
	state_machine.transition_to("Idle", {})


func exit() -> void:
	player.set_collision_mask_value(2, true)
	timer.timeout.disconnect(finish_frenzy)
