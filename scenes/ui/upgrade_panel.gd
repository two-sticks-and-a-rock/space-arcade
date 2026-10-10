extends MarginContainer

@onready var v_container : VBoxContainer = $VBoxContainer
@onready var name_label : Label = $VBoxContainer/Name
@onready var img : TextureRect = $VBoxContainer/Img
@onready var button : Button = $Button as Button

@onready var mechanic_label_scene : PackedScene = load("res://scenes/ui/upgrade_mechanics_text.tscn")

@export var upgrade_name : String
@export var img_filepath : String
@export var mechanics : Array[String] = []
var on_panel_pressed: Callable

func _ready():
	name_label.text = upgrade_name
	if (img_filepath):
		img.texture = load(img_filepath) as Texture2D

	for mechanic in mechanics:
		var mechanic_label = mechanic_label_scene.instantiate() as Label
		mechanic_label.text = mechanic
		v_container.add_child(mechanic_label)
	button.pressed.connect(on_panel_pressed)
