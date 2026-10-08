extends PlayerWeapon

@export var orbiter_scene : PackedScene
@onready var ring : Node2D = $Ring

var size = 10
var spin_speed = PI/24
var distance_from_player = 200

func _get_bullets():
	return 2

func _get_dmg():
	return 50

func _get_up_time():
	return 8

func _get_down_time():
	return 6

func _ready():
	super()
	var child_pos = Vector2(distance_from_player, 0)
	var bullets = _get_bullets()
	for i in bullets:
		var orbiter = orbiter_scene.instantiate() as Area2D
		orbiter.position = child_pos
		ring.add_child(orbiter)
		child_pos = child_pos.rotated(2*PI / bullets)

func _on_down_timer_timeout():
	super()
	ring.visible = true
	ring.process_mode = Node.PROCESS_MODE_INHERIT

func _on_up_timer_timeout():
	super()
	ring.visible = false
	ring.process_mode = Node.PROCESS_MODE_DISABLED
