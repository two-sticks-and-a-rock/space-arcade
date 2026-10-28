class_name TypingTextParagraph
extends VBoxContainer

var current_paragraph: TypingText
var current_index: int = 0
var typing_text_children: Array[Node]
var is_all_text_shown: bool = false

func _ready():
	typing_text_children = get_children().filter(func(child): return child is TypingText)
	current_paragraph = typing_text_children.get(0)
	current_paragraph.start_timer()

func _physics_process(_delta):
	if (current_paragraph.visible_ratio >= 1.0):
		current_index += 1
		if (current_index < typing_text_children.size()):
			current_paragraph = typing_text_children.get(current_index)
			current_paragraph.start_timer()
		else:
			is_all_text_shown = true
	

func show_all_text():
	for child in typing_text_children:
		if child is TypingText:
			child.show_all_text()
	is_all_text_shown = true
			
