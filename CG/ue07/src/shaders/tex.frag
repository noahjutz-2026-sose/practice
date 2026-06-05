#version 150

uniform vec3 cam_pos;

uniform vec3 dirlight_dir;
uniform vec3 dirlight_col;
uniform float dirlight_scale;

uniform vec3 pointlight_pos;
uniform vec3 pointlight_col;
uniform float pointlight_scale;


in vec3 pos_ws;
in vec3 n_ws;

// TODO Uniforms und Input-Attribut

out vec4 out_col;


void main() {
	// TODO Phong-Beleuchtung mit texturierten Oberflächen
	out_col = vec4(0.6,0.1,0.1,1);
}
