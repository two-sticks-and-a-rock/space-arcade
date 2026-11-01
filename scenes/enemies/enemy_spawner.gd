extends Node

@export var run_time : float = 0.0
@export var total_run_time : float = 0.0

@export var max_enemies : int = 300

@export var enemy_scene : PackedScene
@export var enemy_frequency : float = 1.0

@onready var spawn_timer : Timer = $EnemyTimer
@onready var spawn_path : PathFollow2D = $EnemyPath/EnemySpawnLocation

var started_spawning_bigger_elites = false
var started_spawning_faster_elites = false

enum EnemyClass {
	BASE,
	ELITE_BIG, 
	ELITE_FAST,
}
var enemy_spawn: Array[EnemyClass] = [ EnemyClass.BASE ]

func free_all_enemies() -> void:
	for child in get_children():
		if (child is CharacterBody2D):
			child.queue_free()

func _on_restart_game() -> void:
	free_all_enemies()

func _ready() -> void:
	EventBus.restart_game.connect(_on_restart_game)
	spawn_timer.wait_time = enemy_frequency
	spawn_timer.start()

func _on_enemy_timer_timeout() -> void:
	var enemy = enemy_scene.instantiate() as CharacterBody2D
	
	enemy_spawn.shuffle()
	enemy.spawn_enemy(enemy_spawn[0])

	spawn_path.progress_ratio = randf()
	enemy.position = spawn_path.position
	add_child(enemy)

func _physics_process(delta):
	run_time += delta
	total_run_time += delta
	if run_time >= 30:
		run_time = 0
		enemy_frequency = enemy_frequency * 0.9
		spawn_timer.wait_time = enemy_frequency

	if (total_run_time >= 30 && !started_spawning_faster_elites):
		started_spawning_faster_elites = true

		# 75% chance spawn base, 25% chance spawn elite fast
		enemy_spawn = [EnemyClass.BASE, EnemyClass.BASE, EnemyClass.BASE, EnemyClass.ELITE_FAST] 
	
	if (total_run_time >= 60 && !started_spawning_bigger_elites):
		started_spawning_bigger_elites = true

		# 50% chance spawn base, 25% chance spawn elite fast, 25% chance spawn elite big
		enemy_spawn = [EnemyClass.BASE, EnemyClass.BASE, EnemyClass.ELITE_FAST, EnemyClass.ELITE_BIG] 

	var spawned_enemies = get_children().filter(func(child):
		return child is CharacterBody2D
	).size()
	
	if (spawned_enemies >= max_enemies && !spawn_timer.is_stopped()):
		spawn_timer.stop()
	
	if (spawned_enemies < max_enemies && spawn_timer.is_stopped()):
		spawn_timer.start()
