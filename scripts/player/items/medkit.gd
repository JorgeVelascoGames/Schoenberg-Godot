extends Item

class_name Medkit


func _init() -> void:
	source = preload("res://game_resources/items/Medkit.tres")
	
	collectable_name = source.item_name
	time_to_prepare = source.time_to_prepare
	cooldown = source.cooldown
	max_charges = source.max_charges
	current_charges = max_charges
	item_range = source.item_range
	usable = source.usable


func use_item(player: Player):
	player.health.heal()
