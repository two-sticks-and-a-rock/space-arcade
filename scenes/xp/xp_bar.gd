extends ProgressBar

var xp_threshold : int = 5

@onready var viewport_width = get_viewport().size.x

var curr_xp : int = 0
var step_mult : int = 0

var is_leveling_up = false

func _reset_xp() -> void:
	curr_xp = 0
	step_mult = 0

func _ready():
	EventBus.restart_game.connect(_reset_xp)
	EventBus.finish_level_up.connect(_on_finish_level_up)

	max_value = viewport_width
	value = 0
	set_visible_step_mult()

func _physics_process(delta):
	position -= Mover.get_movement()*delta
	position = lerp(position, Vector2.ZERO, 0.1)

	value = curr_xp * step_mult

func set_next_xp_threshold() -> void:
	xp_threshold *= 2

func handle_level_up() -> void:
	curr_xp -= max(xp_threshold, 0)

	EventBus.level_up.emit()

	set_next_xp_threshold()
	set_visible_step_mult()

func gain_xp(xp: int) -> void:
	curr_xp += xp
	if (curr_xp >= xp_threshold && !is_leveling_up):
		is_leveling_up = true
		handle_level_up.call_deferred()

func _on_finish_level_up():
	is_leveling_up = false

func set_visible_step_mult() -> void:
	# TODO: this might have rounding issues if we're not careful 
	# Also we have viewport width pinned right now, that might not be true later
	step_mult = viewport_width / xp_threshold
