extends Collectable

class_name Item

var source: ItemResource

var time_to_prepare: float = 1.0
var cooldown: float = 1.0

var item_range: float

var max_charges: int
var current_charges: int

##If the item can be use (some items work just by holding them)
var usable: bool = true


func equip_item(player: Player):
	pass


func unequip_item():
	pass


func use_item(player: Player):
	pass


func deprecate_item():
	pass
