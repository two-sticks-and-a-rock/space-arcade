extends MarginContainer

@onready var name_label : Label = $VSplitContainer/VBoxContainer/PanelContainer/VBoxContainer/Name
@onready var weapon_label : Label = $VSplitContainer/VBoxContainer/PanelContainer/VBoxContainer/Weapon
@onready var img : TextureRect = $VSplitContainer/VBoxContainer/Img

@onready var mechanics_container: VBoxContainer = $VSplitContainer/VBoxContainer/MechanicsContainer/VBoxContainer
@onready var button : Button = $VSplitContainer/Button as Button

@onready var mechanic_label_scene : PackedScene = load("res://scenes/ui/upgrade_mechanics_text.tscn")
@onready var mechanic_subheader_label_scene : PackedScene = load("res://scenes/ui/upgrade_mechanics_subheader.tscn")

@export var upgrade_name : String
@export var weapon_name : String
@export var img_filepath : String
@export var mechanics : Array[MechanicsText] = []
var on_panel_pressed: Callable

func _ready():
	name_label.text = upgrade_name
	weapon_label.text = weapon_name
	if (img_filepath):
		img.texture = load(img_filepath) as Texture2D

	for mechanic in mechanics:
		var mechanic_subheader_label = mechanic_subheader_label_scene.instantiate() as Label
		mechanic_subheader_label.text = mechanic.mechanic_name
		mechanics_container.add_child(mechanic_subheader_label)

		var mechanic_label = mechanic_label_scene.instantiate() as Label
		mechanic_label.text = mechanic.mechanic_value
		mechanics_container.add_child(mechanic_label)
	button.pressed.connect(on_panel_pressed)
