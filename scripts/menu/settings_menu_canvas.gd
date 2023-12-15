extends CanvasLayer

@onready var fs_checkbox = $Panel/Settings/FullScreen/FSCheckbox
@onready var window_size_options = $Panel/Settings/WindowSize/WindowSizeOptions
@onready var sfx_slider = $Panel/Settings/SFXVolume/SFXSlider
@onready var music_slider = $Panel/Settings/MusicVolume/MusicSlider
@onready var general_slider = $Panel/Settings/GeneralVolume/GeneralSlider


func _on_button_pressed():
	hide()


func _on_fs_checkbox_toggled(button_pressed):
	if button_pressed:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_window_size_options_item_selected(index):
	var size : Vector2
	match index:
		0:
			size = Vector2(640, 360)
		1:
			size = Vector2(1280, 720)
		2:
			size = Vector2(1920, 1080)
		3:
			size = Vector2(3840, 2160)
	
	DisplayServer.window_set_size(size)


func update_vol(index, vol):
	AudioServer.set_bus_volume_db(index, vol)


func _on_general_slider_value_changed(value):
	update_vol(0, value)


func _on_sfx_slider_value_changed(value):	
	update_vol(1, value)


func _on_music_slider_value_changed(value):
	update_vol(2, value)
