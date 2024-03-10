extends CanvasLayer

@onready var settings_menu_canvas = $SettingsMenuCanvas


func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/effects/psx_post_proccesing.tscn")


func _on_settings_button_pressed():
	settings_menu_canvas.show()


func _on_quit_button_pressed():
	get_tree().quit()

