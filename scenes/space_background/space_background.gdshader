shader_type canvas_item;

uniform vec2 offset = vec2(0.0);

uniform float star_1_scroll_mult = 0.01;
uniform float star_2_scroll_mult = 0.05;
uniform float star_3_scroll_mult = 1.0;
uniform float dust_1_scroll_mult = 0.02;
uniform float dust_2_scroll_mult = 0.025;
uniform float dust_3_scroll_mult = 0.04;


uniform sampler2D star_layer_1_noise: repeat_enable;
uniform sampler2D star_layer_2_noise: repeat_enable;
uniform sampler2D star_layer_3_noise: repeat_enable;
uniform sampler2D dust_1_noise: repeat_enable;
uniform sampler2D dust_2_noise: repeat_enable;
uniform sampler2D dust_3_noise: repeat_enable;

vec2 get_new_uv(vec2 uv, float scroll_mult) {
	vec2 new_uv = uv;
	new_uv.x += (offset.x / 1920.0) * scroll_mult;
	new_uv.y += (offset.y / 1080.0) * scroll_mult;
	return new_uv;
}

void fragment() {
	vec4 final_color = vec4(0.0);
	final_color = texture(star_layer_1_noise, get_new_uv(UV, star_1_scroll_mult));
	
	vec4 stars2 = texture(star_layer_2_noise, get_new_uv(UV, star_2_scroll_mult));
	if (stars2.x != 0.0) {
		final_color += stars2;
	}
	
	vec4 stars3 = texture(star_layer_3_noise, get_new_uv(UV, star_3_scroll_mult));
	if (stars3.x != 0.0) {
		final_color += stars3;
	}
	
	vec4 dust1 = texture(dust_1_noise, get_new_uv(UV, dust_1_scroll_mult));
	if (dust1.z != 0.0) {
		final_color += dust1;
	}
	
	vec4 dust2 = texture(dust_2_noise, get_new_uv(UV, dust_2_scroll_mult));
	if (dust2.z != 0.0) {
		final_color += dust2;
	}
	
	vec4 dust3 = texture(dust_3_noise, get_new_uv(UV, dust_3_scroll_mult));
	if (dust3.z != 0.0) {
		final_color += dust3;
	}
	
	COLOR = final_color;
}
