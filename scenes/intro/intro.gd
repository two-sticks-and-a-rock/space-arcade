extends CanvasLayer

@onready var level_scene : PackedScene = load("res://scenes/main.tscn")
@onready var intro_text_box : TypingTextParagraph = $PanelContainer/MarginContainer/IntroTextBox
@onready var skip_button : Button = $PanelContainer/ButtonBox/SkipButton

@onready var player_sprite : Sprite2D = $Player
@onready var engine_burn : Node2D = $Player/engine_burn

@onready var cop1_sprite : Sprite2D = $Cop1
@onready var cop2_sprite : Sprite2D = $Cop2
@onready var space_bg : ColorRect = $PanelContainer/SpaceBackground

@onready var speed_up_timer : Timer = Timer.new()
var num_presses = 0

@onready var slow_down_timer : Timer = Timer.new()

@onready var player_sprite_original_pos = player_sprite.position
var player_sprite_speed : Vector2 = Vector2.ZERO

var speed_up : bool = false
	
func _on_start_speed_up_timer_timeout():
	speed_up_timer.stop()
	speed_up_timer.wait_time = randi_range(5, 11)
	speed_up_timer.start()

	player_sprite_speed = randi_range(100, 250)*Vector2(1,-1)
	# space_bg.x_speed = player_sprite_speed.x
	# space_bg.y_speed = player_sprite_speed.y

	engine_burn._on_engine_burn()
	speed_up = true

	slow_down_timer.start()


func on_start_slow_down_timer_timeout():
	speed_up = false

func _ready():
	speed_up_timer.timeout.connect(_on_start_speed_up_timer_timeout)
	speed_up_timer.wait_time = randi_range(5, 11)
	add_child(speed_up_timer)
	speed_up_timer.start()

	slow_down_timer.one_shot = true
	slow_down_timer.wait_time = 1.5
	slow_down_timer.timeout.connect(on_start_slow_down_timer_timeout)
	add_child(slow_down_timer)

func _physics_process(delta):
	if (speed_up):
		player_sprite.position += player_sprite_speed * delta
	else:
		player_sprite.position = lerp(player_sprite.position, player_sprite_original_pos, 0.01)

func _on_skip_button_pressed():
	if num_presses >= 1 || intro_text_box.is_all_text_shown:
		get_tree().change_scene_to_packed(level_scene)
	else:
		skip_button.text = "CONTINUE..."
		intro_text_box.show_all_text()
		num_presses += 1
