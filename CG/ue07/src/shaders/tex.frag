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
in vec2 tex_coord;

uniform sampler2D diffuse;
uniform sampler2D specular;

out vec4 out_col;


vec3 phong(vec3 n, vec3 l, vec3 v, vec3 I, float ns, vec3 diff_col, vec3 spec_col) {
	float n_dot_l = dot(l, n);
	vec3 res = vec3(0);
	if (n_dot_l > 0) {
		res += diff_col * n_dot_l * I;

		vec3 r = 2.0 * dot(n, l) * n - l;
		res += spec_col * pow(max(0.0, dot(r, v)), ns) * spec_col * I;
	}
	return res;
}


void main() {
	vec3 v = normalize(cam_pos - pos_ws);
	vec3 n = normalize(n_ws);

	vec4 diff_tex = texture(diffuse, tex_coord);
	vec3 diff_col = diff_tex.rgb;
	vec3 spec_col = texture(specular, tex_coord).rgb;

	vec3 dirlight_illum = phong(n, -dirlight_dir, v, 
								dirlight_col*dirlight_scale, 4.0, diff_col, spec_col);

	vec3 to_light = pointlight_pos - pos_ws;
	float dist = length(to_light);
	to_light = normalize(to_light);
	vec3 pointlight_illum = phong(n, to_light, v, 
								  pointlight_col*pointlight_scale, 140.0, diff_col, spec_col);
	pointlight_illum /= (dist/100.0);

	out_col = vec4(dirlight_illum + pointlight_illum, diff_tex.a);
}
