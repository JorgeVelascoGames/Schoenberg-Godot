extends Node3D

class_name ItemManager

@onready var shotgun_model = $ShotgunModel as ItemModelController
@onready var medkit_model = $Medkit_model as ItemModelController

var current_model: ItemModelController


func _ready():
	hide_item()
	current_model = null


func show_item(item_name: String):
	hide_item()
	match item_name:
		"Shotgun":
			shotgun_model.show()
			shotgun_model.play_prepare_item()
			current_model = shotgun_model
		"Medkit":
			medkit_model.show()
			medkit_model.play_prepare_item()
			current_model = medkit_model


func hide_item():
	for item in get_children():
		item.hide()
