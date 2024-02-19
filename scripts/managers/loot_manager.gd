extends Node

var loot_drop_table = WeightedTable.new()

@export_group("Item weights")
@export var shotgun_weight: int = 10
@export var medkit_weight: int = 10
@export var flashlight_weight: int = 10


func populate_loot_table() -> void:
	loot_drop_table.clear_table()
	loot_drop_table.add_item(Shotgun.new(), shotgun_weight)
	loot_drop_table.add_item(Medkit.new(), medkit_weight)
	#loot_drop_table.add_item( flashlight, flashlight_weight)


func pick_random_loot() -> Collectable:
	populate_loot_table()
	return loot_drop_table.pick_item()
