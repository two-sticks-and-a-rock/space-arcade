extends Node2D

@export var orbiter_scene : PackedScene

@export var dmg = 50
@export var bullets = 2

@onready var ring : Node2D = $Ring
@onready var up_timer : Timer = $UpTimer as Timer
@onready var down_timer : Timer = $DownTimer as Timer

var size = 10
var spin_speed = PI/36
var distance_from_player = 200

func _ready():
	var child_pos = Vector2(distance_from_player, 0)
	up_timer.start()
	for i in bullets:
		var orbiter = orbiter_scene.instantiate() as Area2D
		orbiter.position = child_pos
		ring.add_child(orbiter)
		child_pos = child_pos.rotated(2*PI / bullets)

func _on_down_timer_timeout():
	up_timer.start()
	down_timer.stop()
	ring.visible = true
	ring.process_mode = Node.PROCESS_MODE_INHERIT

func _on_up_timer_timeout():
	down_timer.start()
	up_timer.stop()
	ring.visible = false
	ring.process_mode = Node.PROCESS_MODE_DISABLED
