extends ProgressBar

var xp_threshold : int = 5

@onready var viewport_width = get_viewport().size.x

var curr_xp : int = 0
var step_mult : int = 0

func _ready():
	max_value = viewport_width
	value = 0
	set_visible_step_mult()

func _physics_process(delta):
	position -= Mover.get_movement()*delta
	position = lerp(position, Vector2.ZERO, 0.1)

	value = curr_xp * step_mult

func set_next_xp_threshold() -> void:
	xp_threshold = xp_threshold * 2

func handle_level_up():
	curr_xp -= max(xp_threshold, 0)

	set_next_xp_threshold.call_deferred()
	set_visible_step_mult.call_deferred()

	EventBus.level_up.emit()

func gain_xp(xp: int):
	curr_xp += xp
	if (curr_xp >= xp_threshold):
		handle_level_up.call_deferred()

func set_visible_step_mult() -> void:
	# TODO: this might have rounding issues if we're not careful 
	# Also we have viewport width pinned right now, that might not be true later
	step_mult = viewport_width / xp_threshold
