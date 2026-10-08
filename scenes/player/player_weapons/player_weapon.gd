extends Node2D
@onready var up_timer : Timer = $UpTimer as Timer
@onready var down_timer : Timer = $DownTimer as Timer

func _get_dmg():
    return 0

func _get_bullets():
    return 0

func _get_up_time():
    return 0

func _get_down_time():
    return 0

func _ready():
    up_timer.wait_time = _get_up_time()
    down_timer.wait_time = _get_down_time()

    up_timer.start()

func _on_down_timer_timeout():
    down_timer.stop()
    up_timer.start()

func _on_up_timer_timeout():
    up_timer.stop()
    down_timer.start()
