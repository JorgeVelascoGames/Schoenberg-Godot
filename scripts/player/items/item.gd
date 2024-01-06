extends Collectable

class_name Item #This class is a blueprint for all the items to inherit

var source: ItemResource #This is a resource with the data for the item to edit in the project files

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
