extends Node2D

@export var enemy_scene : PackedScene

func new_game():
	# $Player.start($StartPosition.position)
	$EnemyTimer.start()

# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_enemy_timer_timeout():
	# Create a new instance of the Mob scene.
	var enemy = enemy_scene.instantiate()

	# Choose a random location on Path2D.
	var mob_spawn_location = $player/EnemyPath/EnemySpawnLocation
	mob_spawn_location.progress_ratio = randf()

	# Set the mob's position to the random location.
	enemy.position = mob_spawn_location.position

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	enemy.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	enemy.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(enemy)
