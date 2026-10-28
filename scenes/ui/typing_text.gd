class_name TypingText
extends RichTextLabel

var percent_to_show: float
@onready var typing_timer : Timer = $TypingTimer

func _ready():
	typing_timer.timeout.connect(_on_typing_timer_timeout)
	visible_ratio = 0.0
	percent_to_show = 1.0 / text.length()

func start_timer():
	typing_timer.start()

func _on_typing_timer_timeout():
	visible_ratio += percent_to_show
	if visible_ratio >= 1.0:
		typing_timer.stop()

func show_all_text():
	visible_ratio = 1.0
