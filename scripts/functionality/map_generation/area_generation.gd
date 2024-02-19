extends Node3D
class_name AreaGeneration #Este script genera el área eligiendo entre varias plantillas

signal AreaReady

@export var option_areas: Array[PackedScene] = []


# Called when the node enters the scene tree for the first time.
func _ready():
	select_area()


func select_area():
	var selected_node : PackedScene = option_areas.pick_random() as PackedScene
	
	var new_area: Node3D = selected_node.instantiate() as Node3D
	add_child(new_area)
	var grades_to_rotate: Array[int] = [270, 90, 180]
	new_area.rotate_y(deg_to_rad(grades_to_rotate.pick_random()))
	
	AreaReady.emit()

#A list of medieval sounding names
