extends CanvasLayer

@onready var level_scene : PackedScene = load("res://scenes/main.tscn")
# @onready var intro_text : RichTextLabel = $PanelContainer/IntroTextBox/IntroText
@onready var intro_text_box : TypingTextParagraph = $PanelContainer/MarginContainer/IntroTextBox
@onready var skip_button : Button = $PanelContainer/ButtonBox/SkipButton

var num_presses = 0

func _on_skip_button_pressed():
	if num_presses >= 1 || intro_text_box.is_all_text_shown:
		get_tree().change_scene_to_packed(level_scene)
	else:
		skip_button.text = "CONTINUE..."
		intro_text_box.show_all_text()
		num_presses += 1
