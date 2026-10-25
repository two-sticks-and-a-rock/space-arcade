extends CanvasLayer

@onready var level_scene : PackedScene = load("res://scenes/main.tscn")
@onready var intro_text : RichTextLabel = $PanelContainer/IntroTextBox/IntroText
@onready var skip_button : Button = $PanelContainer/ButtonBox/SkipButton

var num_presses = 0

func _on_skip_button_pressed():
	if num_presses >= 1 || intro_text.visible_ratio == 1.0:
		get_tree().change_scene_to_packed(level_scene)
	else:
		skip_button.text = "CONTINUE"
		intro_text.show_all_text()
		num_presses += 1
