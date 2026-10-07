extends Camera2D

@export var leading_cam: Node2D

func _physics_process(_delta):
	position = lerp(position, leading_cam.position, 0.1)
