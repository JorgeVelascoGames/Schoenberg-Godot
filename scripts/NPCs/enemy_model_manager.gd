extends Node3D

class_name EnemyModelManager

@onready var animation_player = $AnimationPlayer
@onready var skeleton_3d = $Armature/Skeleton3D
@onready var head_attachment: BoneAttachment3D = $Armature/Skeleton3D/HeadBone

@export var walk_animation_speed: float = 1
@export var idle_animation_speed: float = 1
@export var run_animation_speed: float = 1
@export var reload_animation_speed: float = 1
@export var stun_animation_speed: float = 1


func idle_animation_play():
	animation_player.play("fleshman_animations/fleshman_idle", -1, idle_animation_speed)


func run_animation_play():
	animation_player.play("fleshman_animations/run_fleshman", -1, run_animation_speed)


func reload_animation_play():
	animation_player.play("fleshman_animations/reload_fleshman", -1, reload_animation_speed)


func stun_animation_play():
	animation_player.play("fleshman_animations/stun_fleshman", -1, stun_animation_speed)


func walk_animation_play():
	animation_player.play("fleshman_animations/walk_fleshman", -1, walk_animation_speed)
