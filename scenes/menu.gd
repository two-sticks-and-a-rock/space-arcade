extends CanvasLayer

func _ready():
	pass # Replace with function body.

func _input(_event: InputEvent) -> void:
	if Input.is_action_pressed("pause"):
		get_tree().paused = !get_tree().paused
		