extends Interactable

class_name PickUp

@onready var shotgun = $Shotgun
@onready var medkit = $Medkit

var pick_up: Collectable


func initialize_pick_up(pick_up: Collectable):
	self.pick_up = pick_up
	active_model()


func active_model():
	for item in get_children():
		item.hide()
		item.disabled = true
	
	match pick_up.collectable_name:
		"Shotgun":
			shotgun.visible = true
			shotgun.disabled = false
		"Medkit":
			medkit.visible = true
			medkit.disabled = false


func interact() -> void:
	if pick_up is Item:
		pick_up_item()
	#Falta todo lo demas


func pick_up_item():
	var swap_item: Item
	
	swap_item = player.equipment.equip_new_item(pick_up) 
	
	if swap_item == null:
		queue_free()
		return
	
	initialize_pick_up(swap_item)


func pick_up_material():
	pass


func pick_up_key():
	pass
