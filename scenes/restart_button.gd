extends Button

signal restart_game

func _on_restart_pressed():
	restart_game.emit()

	Mover.reset()
	get_tree().paused = false
	get_tree().reload_current_scene()
