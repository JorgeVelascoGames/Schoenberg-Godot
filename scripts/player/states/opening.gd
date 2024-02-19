extends PlayerState

class_name Opening

@onready var timer = $Timer as Timer
@export var opening_timer: float = 3

var target_chest: Chest


func enter(msg : ={}) -> void:
	if msg.has("Chest"):
		target_chest = msg["Chest"]
	#TODO
	if not target_chest is Chest: #Hay que modificar esto para que valga tambien para limpiar santuarios, abrir puertas etc
		state_machine.transition_to("Idle", {})
		return
	
	player.canMoveAndRotate = false
	timer.wait_time = opening_timer
	timer.start()
	timer.timeout.connect(timer_done)
	#TODO
	#Chest start animation 


func update(delta):
	if !Input.is_action_pressed("interact"):
		state_machine.transition_to("Idle", {})


func timer_done() -> void:
	target_chest.drop_item()
	state_machine.transition_to("Idle", {})


func exit() -> void:
	#TODO
	#Stop animation
	timer.stop()
	timer.timeout.disconnect(timer_done)
	player.canMoveAndRotate = true
