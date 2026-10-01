extends Button

signal restart_game

func _on_restart_pressed():
	emit_signal("restart_game")

	Mover.reset()
	get_tree().paused = false
	get_tree().reload_current_scene()
