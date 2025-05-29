shader_type canvas_item;

uniform vec2 light_position; // In normalized UV space (0 to 1)
uniform float radius : hint_range(0.01, 1.0) = 0.3;
uniform float smoothness : hint_range(0.001, 1.0) = 0.2;
uniform vec4 darkness_color : source_color = vec4(0.0, 0.0, 0.0, 1.0);

void fragment() {
    float dist = distance(UV, light_position);
    float fade = smoothstep(radius, radius + smoothness, dist);
    COLOR = mix(vec4(0.0), darkness_color, fade);
}
