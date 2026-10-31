extends PlayerBullet

@onready var gradient : Sprite2D = $AnimatedSprite2D/gradient2
@onready var gradient2 : Sprite2D = $AnimatedSprite2D/gradient2/gradient
@onready var cracked_ice_animation: AnimatedSprite2D = $AnimatedSprite2D/gradient2/cracked_ice_animation
@onready var thin2 : Sprite2D = $AnimatedSprite2D/gradient2/thin2

var freeze_time : float
func _on_nova_entered(body: Node2D): #_on_nova_entered #_on_orbiter_entered
	if body.is_in_group("enemy") && body.has_method("freeze"):
		body.freeze(freeze_time)
		Sfx.play("frozen_enemy")

func create_icon():
	var fuzzy_circle_mask = gradient.texture.get_image()
	var gradient2_img = gradient2.texture.get_image()
	var cracked_ice_animation_img = cracked_ice_animation.sprite_frames.get_frame_texture("crack", 0).get_image()
	var thin2_img = thin2.texture.get_image()
	fuzzy_circle_mask.resize(cracked_ice_animation_img.get_width(), cracked_ice_animation_img.get_height(), Image.INTERPOLATE_BILINEAR)
	gradient2_img.resize(cracked_ice_animation_img.get_width(), cracked_ice_animation_img.get_height(), Image.INTERPOLATE_BILINEAR)

	var base_img := Image.create(fuzzy_circle_mask.get_width(), fuzzy_circle_mask.get_height(), false, Image.FORMAT_RGBA8)


	var clip_size1 = Rect2i(Vector2i.ZERO, fuzzy_circle_mask.get_size())
	base_img.blit_rect_mask(cracked_ice_animation_img, fuzzy_circle_mask, clip_size1, Vector2i.ZERO)

	var clip_size2 = Rect2i(Vector2i.ZERO, thin2_img.get_size())
	base_img.blit_rect_mask(thin2_img, fuzzy_circle_mask, clip_size2, Vector2i.ZERO)
	base_img.blend_rect(gradient2_img, Rect2i(Vector2i.ZERO, gradient2_img.get_size()), Vector2i.ZERO)
	
	base_img.convert(Image.Format.FORMAT_RGBA8)
	base_img.save_png("res://art/sprites/bullets/cyro_nova/combined_nova_area_texture.png")

func _ready():
	# commented out. Only necessary for generating preview texture
	# create_icon()
	pass
