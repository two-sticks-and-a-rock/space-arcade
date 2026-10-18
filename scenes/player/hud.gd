extends CanvasLayer

@onready var kills_value : Label = $HSplitContainer/HBoxContainer/KillsValue
var total_kills : int = 0
var displayed_zeros : int = 5

@onready var run_time_value : Label = $RunTime
var run_time : float = 0.0

@onready var best_time_value : Label = $HSplitContainer/VBoxContainer/BestTimeValue

func _ready():
	best_time_value.text = TempSaveData.best_time_display
	kills_value.text = Utils.get_kills_with_leading_zeros(0, displayed_zeros)
	EventBus.game_over.connect(_on_game_over)
	EventBus.enemy_death.connect(_on_enemy_death)

func _on_game_over(_game_over_data: EventBus.GameOverData):
	visible = false

func _on_enemy_death():
	total_kills += 1
	kills_value.text = Utils.get_kills_with_leading_zeros(total_kills, displayed_zeros)

func _physics_process(delta):
	run_time += delta
	run_time_value.text = Utils.float_to_displayed_time(run_time)
