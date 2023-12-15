extends Node

class_name LinearResource

@export var max_resource: int
@export var current_resource: int
@export var consumption_per_second: int
@export var regeneration_per_second: int
##With invert_consumption, the UI bar will fill instead of deplete, like a loading bar
@export var invert_consumption: bool
@export var fill_on_ready: bool

var consuming: bool = false
var regenerating: bool = true

var bonusArray: Array[ResoruceBonus]


func _ready() -> void:
	if fill_on_ready:
		fill_resource()


func consume_resource():
	if not consuming:
		return
	
	if current_resource == 0:
		return
	
	current_resource -= consumption_per_second


func regenerate_resource():
	if not regenerating:
		return
	
	if current_resource == max_resource:
		return
	
	current_resource += regeneration_per_second + regen_bonus()


func add_resource(amount: int) -> void:
	current_resource += amount
	
	if current_resource > max_resource:
		current_resource = max_resource


func substract_resource(amount: int) -> void:
	current_resource -= amount
	
	if current_resource < 0:
		current_resource = 0


func deplete_resource():
	current_resource = 0


func fill_resource():
	current_resource = max_resource


func set_resource_consuming():
	consuming = true
	regenerating = false


func set_resource_regenerating():
	consuming = false
	regenerating = true


func set_resource_neutral():
	consuming = false
	regenerating = false


func regen_bonus() -> int:
	var bonus: int
	
	for item in bonusArray:
		bonus += item.bonus
	
	if bonus < 0:
		bonus = 0
	
	return bonus


func _on_timer_timeout() -> void:
	consume_resource()
	regenerate_resource()
