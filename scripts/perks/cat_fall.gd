extends Perk

class_name CatFall

var falling_time: float = 1
@onready var timer = $Timer as Timer


func init_perk(_player:Player) -> void:
	super.init_perk(_player)
	player.state_machine.transitioned.connect(count_jumping_time)


func count_jumping_time(state: String) -> void:
	if state != "Jump":
		return
	
	timer.time = falling_time
	timer.start
	timer.timeout.connect(ready_to_trigger)


func ready_to_trigger() -> void:
	timer.timeout.disconnect(ready_to_trigger)
	player.state_machine.transitioned.connect(trigger_effect)

func trigger_effect() -> void:
	player.state_machine.transitioned.disconect(trigger_effect)
	#TODO
