extends CanvasLayer

func _ready():
	pass # Replace with function body.

func _input(_event: InputEvent) -> void:
	if Input.is_action_pressed("pause"):
		visible = !visible
		get_tree().paused = !get_tree().paused

func _on_quit_pressed():
	get_tree().quit()

func _on_restart_pressed():
	get_tree().reload_current_scene()