extends Node3D

signal WorldReady

#Todos los puntos de spawn
@export var spawn_points: Array[SpawnPoint] = []
#Los nodos que tienen que estar si o si
@export var fixed_locations: Array[PackedScene] = []
#Los nodos de relleno
@export var general_area: PackedScene
#El navmesh
@export var navmesh: NavigationRegion3D

# Called when the node enters the scene tree for the first time.
func _ready():
	generate_world()


func generate_world() -> void:
	spawn_points.shuffle()
	#First, spawn the mandatory areas
	for location in fixed_locations:
		var new_location = location.instantiate() as AreaGeneration
		add_child(new_location)
		var point: SpawnPoint = spawn_points.pop_front() as SpawnPoint
		new_location.global_position = point.use_spawn_point()
	#Then, we fill the rest
	for empty_location in spawn_points:
		var new_area = general_area.instantiate() as AreaGeneration
		add_child(new_area)
		new_area.global_position = empty_location.use_spawn_point()
	
	WorldReady.emit()
	bake_navigation()
	spawn_objectives()
	spawn_items()
	spawn_enemies()


func bake_navigation() -> void:
	if navmesh == null:
		return
	navmesh.bake_navigation_mesh()


func spawn_enemies() -> void:
	pass


func spawn_items() -> void:
	pass


func spawn_objectives() -> void:
	pass
