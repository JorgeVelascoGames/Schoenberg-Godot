extends Interactable

@export_group("Quest")
@export var npc_has_quest: bool = false
@export var quest_completed : bool = false
@export var key_item_name : String
@export_multiline var quest_dialog: String
@export_multiline var quest_completed_dialog: String

@export_group("Perk")
@export var npc_has_perk: bool = false
@export_multiline var interaction_dialog: String


func interact():
	if quest_completed:
		show_completed_quest_dialog()
		return
	
	if is_quest_completed():
		on_quest_completed()
	else:
		show_npc_dialog()


func show_npc_dialog() -> void:
	pass


func show_completed_quest_dialog() -> void:
	pass


func is_quest_completed() -> bool:
	return player.quests.key_items.has(key_item_name)


func on_quest_completed() -> void:
	pass
