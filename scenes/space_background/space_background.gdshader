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

uniform vec4 dust_1_color: source_color;
uniform vec4 dust_2_color: source_color;
uniform vec4 dust_3_color: source_color;

vec4 shift_hue(vec4 color, float shift) {
	vec3 gray = vec3(0.57735);
	vec3 projection = gray * dot(gray, color.rgb);
	vec3 U = color.rgb - projection;
	vec3 V = cross(gray, U);
	vec3 shifted = U * cos(shift * 2.0 * PI) + V * sin(shift * 2.0 * PI) + projection;
	return vec4(shifted, color.a);
}

vec4 get_layer_fragment(sampler2D layer, vec2 uv, float scroll_mult, vec4 hue) {
	vec2 new_uv = uv;
	new_uv.x += (offset.x / 1920.0) * scroll_mult;
	new_uv.y += (offset.y / 1080.0) * scroll_mult;
	vec4 new_color = texture(layer, new_uv);
	if (new_color.a != 0.0) {
		if (hue != vec4(0.0)) {
			return shift_hue(mix(vec4(0.0), hue, new_color.a), length(offset)/500000.0);
		} else {
			return new_color;
		}
	}
	else {
		return vec4(0.0);
	}
}

void fragment() {
	vec4 final_color = vec4(vec3(0.0),1.0);
	final_color += get_layer_fragment(star_layer_1_noise, UV, star_1_scroll_mult, vec4(0.0));
	final_color += get_layer_fragment(star_layer_2_noise, UV, star_2_scroll_mult, vec4(0.0));
	final_color += get_layer_fragment(star_layer_3_noise, UV, star_3_scroll_mult, vec4(0.0));
	
	final_color += get_layer_fragment(dust_1_noise, UV, dust_1_scroll_mult, dust_1_color);
	final_color += get_layer_fragment(dust_2_noise, UV, dust_2_scroll_mult, dust_2_color);
	final_color += get_layer_fragment(dust_3_noise, UV, dust_3_scroll_mult, dust_3_color);
	
	COLOR = final_color;
}
