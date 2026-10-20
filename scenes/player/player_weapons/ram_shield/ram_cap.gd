extends PlayerBullet


func _ready():
	bullet_scale = Vector2.ONE*1.5

	super()

func _physics_process(_delta):
	sprite.look_at(-1*get_global_mouse_position())
