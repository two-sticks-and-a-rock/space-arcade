extends CanvasLayer

@onready var credits: Container = $Credits
@onready var main_menu_ui: Container = $MainMenu/VBoxContainer

func _ready():
	credits.visible = false
	main_menu_ui.visible = true
	(credits.get_node("MarginContainer/VBoxContainer/Button") as Button).pressed.connect(_on_credits_main_menu_button_pressed)

func _on_credits_button_pressed():
	credits.visible = true
	main_menu_ui.visible = false

func _on_credits_main_menu_button_pressed():
	credits.visible = false
	main_menu_ui.visible = true
