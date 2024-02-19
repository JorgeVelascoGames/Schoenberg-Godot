extends Interactable

class_name Chest

var pick_up = preload("res://scenes/interacts/PickUp.tscn")


func interact() -> void:
	player.start_long_interaction(self)


func drop_item() -> void:
	var item: PickUp = pick_up.instantiate() as PickUp
	get_parent_node_3d().add_child(item)
	item.global_position = global_position
	
	item.initialize_pick_up(choose_item())
	queue_free() #TODO


func choose_item() -> Collectable:
	return LootManager.pick_random_loot()
