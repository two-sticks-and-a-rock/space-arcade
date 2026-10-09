extends Node2D

@export var enemy_scene : PackedScene

func new_game():
	$EnemyTimer.start()

func _on_restart():
	free_enemies()

func free_enemies():
	for child in get_children():
		if (child is CharacterBody2D):
			child.queue_free()

func _ready():
	EventBus.restart_game.connect(_on_restart)
	new_game()

func _on_enemy_timer_timeout():
	# Create a new instance of the Mob scene.
	var enemy = enemy_scene.instantiate() as CharacterBody2D

	# Choose a random location on Path2D.
	var enemy_spawn_pos = $player/EnemyPath/EnemySpawnLocation
	enemy_spawn_pos.progress_ratio = randf()

	# Set the mob's position to the random location.
	enemy.position = enemy_spawn_pos.position

	# Spawn the mob by adding it to the Main scene.
	add_child(enemy)
