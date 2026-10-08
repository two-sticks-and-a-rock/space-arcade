extends CanvasLayer

@onready var upgrade_panel_scene : PackedScene = load("res://scenes/upgrade_menu/upgrade_panel.tscn")
@onready var h_container : HBoxContainer = $PanelContainer/HBoxContainer

func _ready():
	visible = false
	for i in 3:
		var upgrade_panel = upgrade_panel_scene.instantiate()

		h_container.add_child(upgrade_panel)
	