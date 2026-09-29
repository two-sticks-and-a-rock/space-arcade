extends StaticBody2D

func _physics_process(_delta):
	constant_linear_velocity = Mover.get_movement()
