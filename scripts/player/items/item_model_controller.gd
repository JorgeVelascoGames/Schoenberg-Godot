extends Node3D

class_name ItemModelController

@onready var animation_player = $AnimationPlayer


func play_prepare_item():
	animation_player.play("prepare_item")


func play_use_item():
	animation_player.play("use_item")


func stop_animation():
	animation_player.play("RESET")
