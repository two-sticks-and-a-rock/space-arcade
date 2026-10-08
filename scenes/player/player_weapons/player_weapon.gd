class_name PlayerWeapon 
extends Node2D

@onready var up_timer : Timer = $UpTimer as Timer
@onready var down_timer : Timer = $DownTimer as Timer

@export var dmg = 0
@export var bullets = 0

func _ready():
    up_timer.start()

func _on_down_timer_timeout():
    down_timer.stop()
    up_timer.start()

func _on_up_timer_timeout():
    up_timer.stop()
    down_timer.start()
