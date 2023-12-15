extends State

class_name NPCState

var brain : EnemyBrain


func _ready():
	await owner.ready
	brain = owner as EnemyBrain
	
	assert(brain != null, "Invalid state node")
