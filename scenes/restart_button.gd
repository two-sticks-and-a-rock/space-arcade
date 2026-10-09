extends Button

func _on_restart_pressed():
	EventBus.restart_game.emit()
	
	get_tree().paused = false
	get_tree().reload_current_scene()
