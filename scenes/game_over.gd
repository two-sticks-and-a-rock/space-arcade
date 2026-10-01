extends CanvasLayer

@onready var main = get_parent()

func _ready():
	visible = false

func _on_restart_button_pressed():
	main.free_enemies()

func _on_player_game_over():
	get_tree().paused = true
	visible = true
