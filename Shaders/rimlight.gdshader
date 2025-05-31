shader_type canvas_item;

// === TEXTURE INPUTS ===
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture;

// === RESOLUTION ===
uniform vec2 resolution = vec2(320.0, 180.0);

// === CRT FX ===
uniform float scan_line_amount = 1.0;
uniform float warp_amount = 0.025;
uniform float noise_amount = 0.01;
uniform float interference_amount = 0.05;
uniform float grille_amount = 0.025;
uniform float grille_size = 1.0;
uniform float vignette_amount = 0.3;
uniform float vignette_intensity = 0.65;
uniform float aberation_amount = 0.03;
uniform float roll_line_amount = 0.1;
uniform float roll_speed = 0.5;
uniform float scan_line_strength = -4.0;
uniform float pixel_strength = -1.5;

float random(vec2 uv) {
    return fract(cos(uv.x * 83.4827 + uv.y * 92.2842) * 43758.5453123);
}

vec3 fetch_pixel(vec2 uv, vec2 off) {
    vec2 pos = floor(uv * resolution + off) / resolution + vec2(0.5) / resolution;
    float noise = noise_amount > 0.0 ? random(pos + fract(TIME)) * noise_amount : 0.0;
    if (max(abs(pos.x - 0.5), abs(pos.y - 0.5)) > 0.5) return vec3(0.0);
    return texture(SCREEN_TEXTURE, pos, -16.0).rgb + noise;
}

vec2 Dist(vec2 pos) {
    pos *= resolution;
    return -((pos - floor(pos)) - vec2(0.5));
}

float Gaus(float pos, float scale) {
    return exp2(scale * pos * pos);
}

vec3 Horz3(vec2 pos, float off) {
    vec3 b = fetch_pixel(pos, vec2(-1.0, off));
    vec3 c = fetch_pixel(pos, vec2( 0.0, off));
    vec3 d = fetch_pixel(pos, vec2( 1.0, off));
    float dst = Dist(pos).x;
    float wb = Gaus(dst - 1.0, pixel_strength);
    float wc = Gaus(dst, pixel_strength);
    float wd = Gaus(dst + 1.0, pixel_strength);
    return (b * wb + c * wc + d * wd) / (wb + wc + wd);
}

float Scan(vec2 pos, float off) {
    float dst = Dist(pos).y;
    return Gaus(dst + off, scan_line_strength);
}

vec3 Tri(vec2 pos) {
    vec3 clr = fetch_pixel(pos, vec2(0.0));
    if (scan_line_amount > 0.0) {
        vec3 a = Horz3(pos, -1.0);
        vec3 b = Horz3(pos,  0.0);
        vec3 c = Horz3(pos,  1.0);
        float wa = Scan(pos, -1.0);
        float wb = Scan(pos,  0.0);
        float wc = Scan(pos,  1.0);
        clr = mix(clr, a * wa + b * wb + c * wc, scan_line_amount);
    }
    return clr;
}

vec2 warp(vec2 uv) {
    vec2 delta = uv - 0.5;
    float delta2 = dot(delta, delta);
    float delta4 = delta2 * delta2;
    return (uv + delta * (delta4 * warp_amount) - 0.5) / mix(1.0, 1.2, warp_amount / 5.0) + 0.5;
}

float vignette(vec2 uv) {
    uv *= 1.0 - uv;
    return pow(uv.x * uv.y * 15.0, vignette_intensity * vignette_amount);
}

vec3 grille(vec2 uv) {
    float unit = PI / 3.0;
    float scale = 2.0 * unit / grille_size;
    float r = smoothstep(0.5, 0.8, cos(uv.x * scale - unit));
    float g = smoothstep(0.5, 0.8, cos(uv.x * scale + unit));
    float b = smoothstep(0.5, 0.8, cos(uv.x * scale + 3.0 * unit));
    return mix(vec3(1.0), vec3(r, g, b), grille_amount);
}

float roll_line(vec2 uv) {
    float x = uv.y * 3.0 - TIME * roll_speed;
    float f = cos(x) * cos(x * 2.35 + 1.1) * cos(x * 4.45 + 2.3);
    return smoothstep(0.5, 0.9, f) * roll_line_amount;
}

void fragment() {
    vec2 pix = FRAGCOORD.xy;
    vec2 pos = warp(SCREEN_UV);
    float line = roll_line(pos);
    vec2 sq_pix = floor(pos * resolution) / resolution + vec2(0.5) / resolution;
    if (interference_amount + roll_line_amount > 0.0) {
        float interference = random(sq_pix.yy + fract(TIME));
        pos.x += (interference * (interference_amount + line * 6.0)) / resolution.x;
    }
    vec3 clr = Tri(pos);
    if (aberation_amount > 0.0) {
        float chromatic = aberation_amount + line * 2.0;
        vec2 cx = vec2(chromatic, 0.0) / resolution.x;
        vec2 cy = vec2(0.0, chromatic / 2.0) / resolution.y;
        clr = vec3(Tri(pos - cx).r, Tri(pos + cy).g, Tri(pos + cx).b);
    }
    if (grille_amount > 0.0) clr *= grille(pix);
    clr *= 1.0 + scan_line_amount * 0.3 + line * 1.5 + grille_amount * 0.75;
    if (vignette_amount > 0.0) clr *= vignette(pos);
    COLOR = vec4(clr, 1.0);
}
