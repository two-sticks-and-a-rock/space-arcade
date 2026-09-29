extends Camera2D


func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	position -= Mover.get_movement()*delta
	position = lerp(position, Vector2.ZERO, 0.1)