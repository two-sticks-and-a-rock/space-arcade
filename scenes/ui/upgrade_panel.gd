extends MarginContainer

@onready var name_label : Label = $VSplitContainer/VBoxContainer/PanelContainer/VBoxContainer/Name
@onready var weapon_label : Label = $VSplitContainer/VBoxContainer/PanelContainer/VBoxContainer/Weapon
@onready var description_label : RichTextLabel = $VSplitContainer/VBoxContainer/UpgradeMechanicsText
@onready var img : TextureRect = $VSplitContainer/VBoxContainer/Img

@onready var mechanics_container: VBoxContainer = $VSplitContainer/VBoxContainer/MechanicsContainer/VBoxContainer
@onready var button : Button = $VSplitContainer/Button as Button
var show_button : bool = true

@onready var mechanic_label_scene : PackedScene = load("res://scenes/ui/upgrade_mechanics_text.tscn")
@onready var mechanic_subheader_label_scene : PackedScene = load("res://scenes/ui/upgrade_mechanics_subheader.tscn")

@export var upgrade_name : String
@export var weapon_name : String
@export var img_filepath : String
@export var mechanics : Array[MechanicsText] = []
@export var description : String = ""
@export var show_description : bool = false

var on_panel_pressed: Callable = func(): pass

func generate_h_box() -> HBoxContainer:
	var row = HBoxContainer.new()
	row.alignment = BoxContainer.ALIGNMENT_CENTER
	row.custom_maximum_size.x = 500.0
	return row

func populate_mechanics():
	var current_row = generate_h_box()

	var items_in_row = 0

	for mechanic in mechanics:
		var mechanic_subheader_label = mechanic_subheader_label_scene.instantiate() as Label
		mechanic_subheader_label.text = mechanic.mechanic_name
		var mechanic_label = mechanic_label_scene.instantiate() as Label
		mechanic_label.text = mechanic.mechanic_value

		var v_box = VBoxContainer.new()
		v_box.alignment = BoxContainer.ALIGNMENT_CENTER
		v_box.custom_minimum_size.x = 200.0
		v_box.add_theme_constant_override("separation", -4)

		if mechanic.col_span == 2:
			v_box.add_child(mechanic_subheader_label)
			v_box.add_child(mechanic_label)
			current_row.add_child(v_box)
			items_in_row = 2
		else:
			v_box.add_child(mechanic_subheader_label)
			v_box.add_child(mechanic_label)
			current_row.add_child(v_box)
			items_in_row += 1

		if (items_in_row == 2):
			mechanics_container.add_child(current_row)
			current_row = generate_h_box()
			items_in_row = 0
		
	if (items_in_row > 0):
		mechanics_container.add_child(current_row)
	else:
		current_row.queue_free()

func _ready():
	name_label.text = upgrade_name
	weapon_label.text = weapon_name
	if (img_filepath):
		img.texture = load(img_filepath) as Texture2D

	if (show_description):
		description_label.text = description
	else:
		description_label.visible = false

	populate_mechanics()

	if !show_button:
		button.visible = false
	button.pressed.connect(on_panel_pressed)
