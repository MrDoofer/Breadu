shader_type canvas_item;

void fragment() {
	vec4 tex_color = texture(TEXTURE, UV);
	COLOR = tex_color;
	COLOR.rgb *= 10.0; // makes it emit light
}
