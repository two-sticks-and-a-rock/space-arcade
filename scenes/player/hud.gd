extends CanvasLayer

@onready var kills_value : Label = $HSplitContainer/HBoxContainer/KillsValue
var total_kills = 0

func _ready():
	kills_value.text = str(total_kills)
	EventBus.game_over.connect(_on_game_over)
	EventBus.enemy_death.connect(_on_enemy_death)

func _on_game_over(_game_over_data: EventBus.GameOverData):
	visible = false

func _on_enemy_death():
	total_kills += 1
	kills_value.text = str(total_kills)
