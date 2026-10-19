class_name XpPickupable
extends Area2D

@export var xp_value : int = 1
@export var xp_sprite : Texture2D = load("res://art/sprites/xp/gear_placeholder.png") as Texture2D

@onready var player = get_parent().get_node("%player") as StaticBody2D
@onready var sprite : Sprite2D = $Sprite2D
var move_to_player = false

func _on_restart():
	queue_free()

func _ready() -> void:
	EventBus.restart_game.connect(_on_restart)
	sprite.texture = xp_sprite

func _physics_process(delta) -> void:
	position -= Mover.get_movement() * delta
	if (move_to_player):
		position = lerp(position, player.global_position, 0.01)

func _on_gear_entered(body: Node2D) -> void:
	if (body.name == "player" && "gain_xp" in body):
		body.gain_xp(xp_value)
		queue_free()
		Sfx.play("xp_pickup")

func _on_gear_area_exited(area: Area2D) -> void:
	if (area.name == "XpMagnet"):
		move_to_player = false

func _on_gear_area_entered(area: Area2D) -> void:
	if (area.name == "XpMagnet"):
		move_to_player = true
