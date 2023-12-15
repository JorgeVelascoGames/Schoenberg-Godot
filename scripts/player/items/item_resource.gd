extends Resource

class_name ItemResource

@export var item_name: String

@export var time_to_prepare: float = 1.0
@export var cooldown: float = 1.0

@export var item_range:float

@export var max_charges: int
@export var current_charges: int

##If the item can be use (some items work just by holding them)
@export var usable: bool = true
