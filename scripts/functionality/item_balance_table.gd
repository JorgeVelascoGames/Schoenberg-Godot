class_name CollectableWeightTable

var items: Array[Dictionary] = []

var medkit_count: int = 0
var shotgun_count: int = 0


func _init():
	var weight: int
	items.append({"item": Collectable, "weight": weight})


func get_item() -> Collectable:
	return null
