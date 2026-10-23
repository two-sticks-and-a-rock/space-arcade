extends Node2D

var click_and_drag_tutorial_scene : PackedScene = load("res://scenes/ui/tutorial/click_and_drag.tscn")
var upgrade_menu_scene : PackedScene = load("res://scenes/ui/upgrade_menu.tscn")
@onready var player: StaticBody2D = $player

func _on_start_tutorial():
	var tutorial = click_and_drag_tutorial_scene.instantiate()
	add_child(tutorial)

func _ready():
	EventBus.get_starting_weapon.emit()
	if !EventBus.start_tutorial.is_connected(_on_start_tutorial):
		EventBus.start_tutorial.connect(_on_start_tutorial)

	get_tree().paused = true

func _physics_process(_delta):
	pass
