extends Node

class_name Equipment

##This timer is used to prevent insta switching
@onready var timer: Timer = $SwapCooldown
@onready var item: Label = $"../PlayerUI/Item"
@onready var item_secondary: Label = $"../PlayerUI/Item_secondary"

var active_item: Item
var backup_item: Item


func _input(event):
	if event.is_action("swap_item"):
		swap_item()


func equip_new_item(new_item: Item) -> Item:
	if timer.time_left > 0:
		return
	
	if active_item == null:
		active_item = new_item
		update_ui()
		timer.start()
		return null
	
	if backup_item == null:
		backup_item = new_item
		update_ui()
		timer.start()
		return null
	
	var drop_item = active_item
	active_item = new_item
	print(new_item.item_name)
	update_ui()
	timer.start()
	
	return drop_item


func swap_item():
	if timer.time_left > 0:
		return
	
	if backup_item == null:
		return
	
	var temp: Item = active_item
	active_item = backup_item
	backup_item = temp
	
	update_ui()
	timer.start()


func update_ui():
	if active_item != null:
		item.text = active_item.collectable_name
	
	if backup_item != null:
		item_secondary.text = backup_item.collectable_name
