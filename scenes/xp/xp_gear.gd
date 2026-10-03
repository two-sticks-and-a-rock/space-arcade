extends Area2D

@onready var player = get_parent().get_node("%player") as StaticBody2D
var move_to_player = false

func _physics_process(delta):
	position -= Mover.get_movement() * delta
	if (move_to_player):
		position = lerp(position, player.global_position, Xp.XP_MAGNET_SPEED)

func _on_gear_entered(body: Node2D):
	if (body.name == "XpMagnet"):
		move_to_player = true
		
	if (body.name == "player" && "gain_xp" in body):
		body.gain_xp(Xp.GEAR_VALUE)
		queue_free()

func _on_gear_area_exited(area: Area2D):
	if (area.name == "XpMagnet"):
		move_to_player = false

func _on_gear_area_entered(area: Area2D):
	if (area.name == "XpMagnet"):
		move_to_player = true
