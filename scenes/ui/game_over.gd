extends CanvasLayer

@onready var kills_value : Label = $PanelContainer/VBoxContainer/KillsValue

func _ready():
	EventBus.restart_game.connect(_on_restart)
	EventBus.game_over.connect(_on_player_game_over)
	EventBus.switch_scenes.connect(_on_switch_scenes)
	visible = false

func _on_switch_scenes(_sceneType: EventBus.SceneType) -> void:
	visible = false
	get_tree().paused = false

func _on_player_game_over(game_over_data: EventBus.GameOverData):
	kills_value.text = "Kills: " + str(game_over_data.kills)
	get_tree().paused = true
	visible = true

func _on_restart():
	visible = false
	get_tree().paused = false
