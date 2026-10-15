extends Node2D

@export var visible_icons: bool = false
@export_range(0.0, 0.5, 0.01) var camera_dist : float = 0.15
@export_range(0.0, 0.2, 0.001) var cam_target_speed : float = 0.075
@export_range(0.0, 0.2, 0.001) var cam_follow_speed : float = 0.05

var direction_target: Vector2 = Vector2.ZERO

@onready var camera_target = $Node2D
@onready var camera: Camera2D = $Camera2D

func _ready() -> void:
	$Node2D/Sprite2D.visible = visible_icons
	$Camera2D/Sprite2D.visible = visible_icons

func _physics_process(_delta):
	if Input.is_action_just_pressed("ui_focus_next"):
		$Node2D/Sprite2D.visible = !$Node2D/Sprite2D.visible 
		$Camera2D/Sprite2D.visible = !$Camera2D/Sprite2D.visible
	direction_target = Mover.get_movement() * camera_dist
	camera_target.position = lerp(camera_target.position, direction_target, cam_target_speed)
	camera.position = lerp(camera.position, camera_target.position, cam_follow_speed)
