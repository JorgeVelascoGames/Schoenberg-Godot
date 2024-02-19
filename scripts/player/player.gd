extends CharacterBody3D

class_name Player

@onready var camera_3d = $Camera3D
@onready var ray_cast_ground_detector = $RayCasts/RayCastGroundDetector
@onready var state_machine = $StateMachine
@onready var footstep_sound = $FootstepSound
@onready var health: Health = $Health as Health
@onready var stamina: LinearResource = $Stamina as LinearResource
@onready var ray_cast_item_use: RayCast3D = $Camera3D/RayCastItemUse as RayCast3D
@onready var ray_cast_interact: RayCast3D = $Camera3D/RayCastInteract as RayCast3D
@onready var equipment: Equipment = $Equipment as Equipment
@onready var quests: PlayerQuestTracker = $Quests as PlayerQuestTracker

var canMoveAndRotate = true
var mouse_sens : float = 0.15

const GRAVITY = 16
@export_group("Physics settings")
@export var jump_force = 14
@export var air_acceleration = 10


var joystick_deadznoe : float = 0.2
var controller_sensitivity :float = 0.05
var friction : float = 20
var direction : Vector3

@export_group("Movement stats")
@export var speed: float = 5
@export var run_speed: float = 9
@export var run_back_speed: float = 6
@export var fatal_speed: float = 4
@export var crouch_speed: float = 2
@export var frenzy_speed: float = 12
@export var frenzy_duration: float = 4.0
@export var accel: float = 2
@export var speed_bonus: float = 0
@export_group("Movement settings")
@export var can_jump : bool = false
@export var can_move_on_air : bool = false

@export_group("Miscelanea")
@export var camBobSpeed = 2
@export var camBobUpDown = .3
var _delta = 0
@onready var originCamPos : Vector3 = camera_3d.position

var force_look_down: bool = false

var distanceFootstep = 0.0
var playFootstep = 1


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _input(event):
	if canMoveAndRotate:
		rotate_camera(event)


func _process(delta):
	if canMoveAndRotate:
		process_camera_joystick()
	
	process_input(delta)
	processGroundSounds()
	process_gravity(delta)
	force_camera_look_down()


func get_speed(state: State):
	var final_speed: float = speed
	
	if state is Walk:
		if health.current_health_state == health.health_states.fatal:
				final_speed = fatal_speed
		else:
			final_speed = speed
	
	if state is Run:
		if Input.is_action_pressed("move_down"):
			final_speed = run_back_speed
		else:
			final_speed = run_speed
	if state is Frenzy:
		final_speed =  frenzy_speed
		
	if state is Crouch:
		final_speed =  crouch_speed
	
	final_speed += speed_bonus
	
	return final_speed


func got_hit():
	state_machine.transition_to("Frenzy", {})


func rotate_camera(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sens))
		camera_3d.rotate_x(deg_to_rad(-event.relative.y * mouse_sens))
		camera_3d.rotation.x = clamp(camera_3d.rotation.x, deg_to_rad(-89), deg_to_rad(89))


func process_camera_joystick():
	if Input.get_joy_axis(0, 2) < -joystick_deadznoe or Input.get_joy_axis(0, 2) > joystick_deadznoe:
		rotation.y -= Input.get_joy_axis(0, 2) * controller_sensitivity
	
	if Input.get_joy_axis(0, 3) < -joystick_deadznoe or Input.get_joy_axis(0, 3) > joystick_deadznoe:
		camera_3d.rotation.x = clamp(camera_3d.rotation.x - Input.get_joy_axis(0, 3) * controller_sensitivity,\
		 -1.55, 1.55)


func force_camera_look_down():
	if not force_look_down:
		return
	
	var force: int = 40
	camera_3d.rotate_x(deg_to_rad(-force * mouse_sens))
	camera_3d.rotation.x = clamp(camera_3d.rotation.x, deg_to_rad(-70), deg_to_rad(70))


func process_input(delta) -> Vector3:
	_delta += delta
	direction = Vector3.ZERO
	var h_rot = global_transform.basis.get_euler().y
	
	var forward_input = Input.get_action_strength("move_down")-Input.get_action_strength("move_up")
	var side_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	direction = Vector3(side_input, 0, forward_input).rotated(Vector3.UP, h_rot).normalized()
	return direction


func process_gravity(delta):
	if is_on_floor():
		return
	
	velocity.y -= GRAVITY * delta


func processGroundSounds():
	var st = state_machine.get_state()
	match st:
		"Run":
			playFootstep = 2
		"Walk":
			playFootstep = 3
		"Crouch":
			playFootstep = 5
		_:
			playFootstep = 100
	
	if playFootstep != 100 and (int(velocity.x) != 0) || int(velocity.z) != 0:
		distanceFootstep += .1
	
	if distanceFootstep > playFootstep and is_on_floor():
		if ray_cast_ground_detector.is_colliding():
			var floorName = ray_cast_ground_detector.get_collider().get_parent()
			if floorName != null and floorName is MeshInstance3D and floorName.get_active_material(0) != null:
				var nameMat = floorName.get_active_material(0).resource_path
				
				if "Grass" in nameMat:
					footstep_sound.stream = load("res://assets/SFX/footsteps/leaves01.ogg")
				elif "Wood" in nameMat: 
					footstep_sound.stream = load("res://assets/SFX/footsteps/wood01.ogg")
				elif "Snow" in nameMat:
					footstep_sound.stream = load("res://assets/SFX/footsteps/SnowWalk/SnowWalk2.ogg")
				elif "Concrete" in nameMat:
					footstep_sound.stream = load("res://assets/SFX/footsteps/gravel.ogg")
				else:
					footstep_sound.stream = load("res://assets/SFX/footsteps/stone01.ogg")
			footstep_sound.pitch_scale = randf_range(.8, 1.2)
			footstep_sound.play()
			distanceFootstep = 0


func interact():
	var interact: Interactable
	
	if not ray_cast_interact.is_colliding():
		return
	
	var collision = ray_cast_interact.get_collider()
	
	if collision is Interactable:
		collision.interact()


func _on_health_lost_health_state() -> void:
	got_hit()


func start_long_interaction(interactable: Interactable) -> void:
	state_machine.transition_to("Opening", {"Chest": interactable})
