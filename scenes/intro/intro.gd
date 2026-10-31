extends CanvasLayer

@onready var level_scene : PackedScene = load("res://scenes/main.tscn")
@onready var intro_text_box : TypingTextParagraph = $PanelContainer/MarginContainer/IntroTextBox
@onready var skip_button : Button = $PanelContainer/ButtonBox/SkipButton

@onready var player_sprite : Node2D = $Player

@onready var engine_burn : Node2D = $Player/Player/engine_burn
@onready var look_at: Node2D = $LookAt

@onready var cop1_sprite : Node2D = $Cop1
@onready var cop2_sprite : Node2D = $Cop2
@onready var space_bg : ColorRect = $PanelContainer/SpaceBackground

@onready var speed_up_timer : Timer = Timer.new()
var num_presses = 0

@onready var slow_down_timer : Timer = Timer.new()

@onready var player_sprite_original_pos = player_sprite.position
var player_sprite_speed : float = 0.0
@onready var look_at_original_pos = look_at.position

@onready var cop1_sprite_original_pos = cop1_sprite.position
@onready var cop2_sprite_original_pos = cop2_sprite.position
var enemy_sprite_speed : Vector2 = Vector2.ZERO
var enemy1_delay : float = 0.5
var enemy2_delay : float = 1.0

var speed_up : bool = false
var time_elapsed : float = 0.0

func _on_start_speed_up_timer_timeout():
	speed_up_timer.stop()
	speed_up_timer.wait_time = randi_range(5, 11)
	speed_up_timer.start()

	var speed : float = randi_range(100, 250)
	player_sprite_speed = speed
	enemy_sprite_speed = (speed-randi_range(20, 75))*Vector2(1,-1)

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
	time_elapsed += delta
	look_at.position.y = look_at_original_pos.y + sin(time_elapsed * 2.0) * 100
	player_sprite.look_at(look_at.position)

	cop1_sprite.look_at(look_at.position)
	cop1_sprite.position.y = cop1_sprite_original_pos.y + sin((time_elapsed - 5) * 1.5) * 25
	cop2_sprite.look_at(look_at.position)
	cop2_sprite.position.y = cop2_sprite_original_pos.y + sin((time_elapsed + 10) * 1.0) * 50


	if (speed_up):
		player_sprite.position += player_sprite_speed * Vector2.from_angle(player_sprite.rotation) * delta
		
		if (speed_up_timer.wait_time - speed_up_timer.time_left >= enemy1_delay):
			cop1_sprite.position += enemy_sprite_speed * delta
		if (speed_up_timer.wait_time - speed_up_timer.time_left >= enemy2_delay):
			cop2_sprite.position += enemy_sprite_speed * delta
	else:
		player_sprite.position = lerp(player_sprite.position, player_sprite_original_pos, 0.01)

		cop1_sprite.position = lerp(cop1_sprite.position, cop1_sprite_original_pos, 0.01)
		cop2_sprite.position = lerp(cop2_sprite.position, cop2_sprite_original_pos, 0.03)

func _on_skip_button_pressed():
	if num_presses >= 1 || intro_text_box.is_all_text_shown:
		get_tree().change_scene_to_packed(level_scene)
	else:
		skip_button.text = "CONTINUE..."
		intro_text_box.show_all_text()
		num_presses += 1
