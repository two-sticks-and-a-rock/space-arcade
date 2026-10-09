extends CanvasLayer

func _ready():
	EventBus.game_over.connect(_on_player_game_over)

	visible = false

func _on_player_game_over():
	get_tree().paused = true
	visible = true
