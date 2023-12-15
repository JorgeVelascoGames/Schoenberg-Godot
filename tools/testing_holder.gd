extends Node

@onready var shotgun = $"../Shotgun" as PickUp
@onready var medkit = $"../Medkit" as PickUp

func _ready():
	test()


func test():
	if shotgun == null:
		return
	
	shotgun.initialize_pick_up(Shotgun.new())
	medkit.initialize_pick_up(Medkit.new())
