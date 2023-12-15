extends Node

const SAVEFILE = "user://SAVEFILE.save"

var game_data = {
	
}


func _ready():
	load_data()


func load_data():
	var file = FileAccess.open(SAVEFILE, FileAccess.READ)
	print(file)
	if file == null:
		save_data()
	else:
		game_data = file.get_var()
	save_data()


func save_data():
	var file = FileAccess.open(SAVEFILE, FileAccess.WRITE)
	file.store_var(game_data)
