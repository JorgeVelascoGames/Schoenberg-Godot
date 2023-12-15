extends Item

class_name  Shotgun

var ray: RayCast3D


func _init() -> void:
	source = preload("res://game_resources/items/Shotgun.tres")
	
	collectable_name = source.item_name
	time_to_prepare = source.time_to_prepare
	cooldown = source.cooldown
	max_charges = source.max_charges
	current_charges = max_charges
	item_range = source.item_range
	usable = source.usable


func equip_item(player: Player):
	ray = player.ray_cast_item_use as RayCast3D
	ray.set_collision_mask_value(2, true)
	ray.set_collision_mask_value(3, true)
	ray.enabled = true
	ray.target_position = Vector3(0, 0, -item_range)


func unequip_item():
	ray.set_collision_mask_value(2, false)
	ray.set_collision_mask_value(3, false)
	ray.enabled = false


func use_item(player: Player):
	if ray.is_colliding() and ray.get_collider() is EnemyBrain:
			ray.get_collider().get_stuned()

