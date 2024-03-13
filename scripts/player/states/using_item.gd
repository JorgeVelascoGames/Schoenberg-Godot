extends PlayerState

class_name UsingItem

@onready var prepare_item_timer: Timer = $PrepareItemTimer as Timer
@onready var cooldown_timer: Timer = $CooldownTimer as Timer
@onready var item_manager = $"../../Camera3D/Items" as ItemManager

var item_ready: bool = false

var item: Item


func enter(_msg : ={}) -> void:
	item = player.equipment.active_item as Item
	item.equip_item(player)
	item_manager.show_item(item.collectable_name)
	player.canMoveAndRotate = false
	player.force_look_down = true
	item_ready = false
	
	cooldown_timer.wait_time = item.cooldown
	prepare_item_timer.timeout.connect(_on_item_ready)
	prepare_item_timer.wait_time = item.time_to_prepare
	player.player_ui.start_progress_bar(item.time_to_prepare)
	prepare_item_timer.start()


func update(_delta: float) -> void:
	if Input.is_action_just_released("prepare_item"):
		state_machine.transition_to("Idle", {})
	
	if not item_ready:
		return
	
	if cooldown_timer.time_left > 0:
		return
	
	if Input.is_action_just_pressed("use_item"):
		use_item()
		cooldown_timer.start()


func use_item() -> void:
	cooldown_timer.start
	item_manager.current_model.play_use_item()
	item.use_item(player)
	item.current_charges -= 1
	
	if item.current_charges <= 0:
		item.deprecate_item()


func _on_item_ready():
	player.canMoveAndRotate = true
	player.force_look_down = false
	item_ready = true
	item_manager.current_model.stop_animation()


func exit() -> void:
	item.unequip_item()
	item_manager.hide_item()
	player.canMoveAndRotate = true
	player.force_look_down = false
	item_ready = false
	player.player_ui.close_progress_bar()
