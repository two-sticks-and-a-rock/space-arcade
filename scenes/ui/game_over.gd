extends CanvasLayer

@onready var kills_value : Label = $PanelContainer/VBoxContainer/KillsValue
@onready var run_time_value : Label = $HSplitContainer/RunTime
@onready var best_time_value : Label = $HSplitContainer/BestTime

func _ready():
	best_time_value.text = "Best: " + TempSaveData.best_time_display
	EventBus.restart_game.connect(_on_restart)
	EventBus.game_over.connect(_on_player_game_over)
	EventBus.switch_scenes.connect(_on_switch_scenes)
	visible = false

func _on_switch_scenes(_sceneType: EventBus.SceneType) -> void:
	visible = false
	get_tree().paused = false

func _on_player_game_over(game_over_data: EventBus.GameOverData):
	kills_value.text = "Kills: " + game_over_data.kills_display
	run_time_value.text = "Time: " + game_over_data.time_display

	if (game_over_data.time > TempSaveData.best_time):
		print("Beat best time!")
		TempSaveData.best_time = game_over_data.time
		TempSaveData.best_time_display = game_over_data.time_display

	get_tree().paused = true
	visible = true

func _on_restart():
	visible = false
	get_tree().paused = false
