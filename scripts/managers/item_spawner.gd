extends Node

var spawn_points: Array[Node3D]
var pick_up: PackedScene = preload("res://scenes/interacts/PickUp.tscn")


func _ready():
	spawn_items(5)


func spawn_items(amount: int):
	if amount > spawn_points.size():
		amount = spawn_points.size()
	
	spawn_points.shuffle()
	
	for n in amount:
		print(n)
	pass
