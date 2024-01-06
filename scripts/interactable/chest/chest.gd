extends Node3D


var pick_up = preload("res://scenes/interacts/PickUp.tscn")


func drop_item() -> void:
	var item: PickUp = pick_up.instance() as PickUp
	item.global_position = global_position
	
	item.initialize_pick_up(choose_item())


func choose_item() -> Collectable:
	var shotgun: Collectable
	#TODO
	return shotgun
