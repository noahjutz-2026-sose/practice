#version 150
#define USE_PHONG_SHADING

// TODO
// Teilaufgabe 3
// Uniforms und Input-Attribute
in vec3 pos_ws;
in vec3 n_ws;
uniform vec3 cam_pos;
uniform vec3 pointlight_pos;
uniform vec3 pointlight_col;
uniform float pointlight_scale;
uniform vec3 dirlight_dir;
uniform vec3 dirlight_col;
uniform float dirlight_scale;
uniform vec4 k_diff;
uniform vec4 k_amb;
uniform vec4 k_spec;

out vec4 out_col;

void main() {
    // TODO
    // Teilaufgabe 3
    // Phong-Beleuchtung für zwei Lichtquellen mit Diffuse und Spekularteil.
    vec3 N = normalize(n_ws);
    vec3 V = normalize(cam_pos - pos_ws);

    // Ambient
    vec3 ambient = 0.1 * k_amb.rgb;

    // Directional: Diffuse
    vec3 L_dir = normalize(-dirlight_dir);
    float diff_coeff = max(dot(N, L_dir), 0.0);
    vec3 diffuse_dir = diff_coeff * dirlight_scale * k_diff.rgb;

    // Directional: Specular
    float shininess = 50;
    vec3 R_dir = reflect(-L_dir, N);
    float spec_coeff = pow(max(dot(R_dir, V), 0.0), shininess);
    vec3 specular_dir = spec_coeff * dirlight_col * dirlight_scale * vec3(1.0);

    // Point
    vec3 to_light = pointlight_pos - pos_ws;
    float d = length(to_light);
    vec3 L_pt = to_light / d;
    float attenuation = 1.0 / (d * d);

    // Point: Diffuse
    float diff_coeff_pt = max(dot(N, L_pt), 0.0);
    vec3 diffuse_pt = diff_coeff_pt * pointlight_col * pointlight_scale * k_diff.rgb;

    // Point: Specular
    vec3 R_pt = reflect(-L_pt, N);
    float spec_coeff_pt = pow(max(dot(R_dir, V), 0.0), shininess);
    vec3 spec_pt = spec_coeff_pt * pointlight_col * pointlight_scale * vec3(1.0);

    out_col = vec4(ambient + diffuse_dir + specular_dir + diffuse_pt + spec_pt, k_diff.a);
}
