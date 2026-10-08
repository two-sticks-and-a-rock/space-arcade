extends PlayerWeapon

@export var orbiter_scene : PackedScene
@onready var ring : Node2D = $Ring

var size = 10
var distance_from_player = 200

func _ready():
	var child_pos = Vector2(distance_from_player, 0)
	up_timer.start()
	
	for i in bullets:
		var orbiter = orbiter_scene.instantiate() as Area2D
		orbiter.position = child_pos
		add_child(orbiter)
		child_pos = child_pos.rotated(2*PI / bullets)

func _on_down_timer_timeout():
	super()
	for child in get_children():
		if child is Area2D:
			ring.process_mode = Node.PROCESS_MODE_INHERIT

func _on_up_timer_timeout():
	super()
	for child in get_children():
		if child is Area2D:
			ring.process_mode = Node.PROCESS_MODE_INHERIT
