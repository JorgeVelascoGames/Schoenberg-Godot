extends PlayerState

class_name PlayerIdle

@onready var ray_cast_check_cover: RayCast3D = $"../../Camera3D/RayCastCheckCover"


func enter(_msg : ={}) -> void:
	player.velocity = Vector3.ZERO
	if player.health.current_health_state <= 2:
		player.stamina.set_resource_regenerating()
	else:
		player.stamina.set_resource_neutral()


func update(delta):
#	player._delta += delta
#	var cam_bob = floor(abs(1)+abs(1)) * player._delta * 1
#	var objCam = player.originCamPos + Vector3.UP * sin(cam_bob) * .05
#
#	player.camera_3d.position = player.camera_3d.position.lerp(objCam, delta)
	
	if Input.is_action_just_pressed("interact"):
		player.interact()
	
	if Input.is_action_just_pressed("prepare_item") and player.equipment.active_item != null:
		state_machine.transition_to("UsingItem", {})
	
	if player._delta > 10:
		player._delta = 0


func physics_update(delta: float) -> void:
	if player.process_input(delta) != Vector3.ZERO:
		state_machine.transition_to("Walk", {})
		return
	
	if Input.is_action_pressed("action_crouch"):
		state_machine.transition_to("Crouch", {})
	
	if ray_cast_check_cover.is_colliding() and (Input.is_action_pressed("peak_left") or Input.is_action_pressed("peak_right")):
		state_machine.transition_to("Peak", {})
	
	if !player.is_on_floor():
		state_machine.transition_to("Jump", {})
	
	if Input.is_action_just_pressed("do_jump") and player.can_jump:
		state_machine.transition_to("Jump", {do_jump = true})
	
	player.velocity = player.velocity.lerp(Vector3.ZERO, player.friction * delta)
	player.move_and_slide()
