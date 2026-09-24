extends Node2D

@export var enemy_scene : PackedScene

func new_game():
	# $Player.start($StartPosition.position)
	$EnemyTimer.start()

# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()

func _on_enemy_timer_timeout():
	# Create a new instance of the Mob scene.
	var enemy = enemy_scene.instantiate() as RigidBody2D

	# Choose a random location on Path2D.
	var enemy_spawn_pos = $player/EnemyPath/EnemySpawnLocation
	enemy_spawn_pos.progress_ratio = randf()

	# Set the mob's position to the random location.
	enemy.position = enemy_spawn_pos.position

	# Spawn the mob by adding it to the Main scene.
	add_child(enemy)
