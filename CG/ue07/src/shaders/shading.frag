#version 150
#define USE_PHONG_SHADING

#ifdef USE_PHONG_SHADING
// {{{
uniform vec4 k_diff;
uniform vec4 k_spec;
uniform vec3 dirlight_dir;
uniform vec3 dirlight_col;
uniform float dirlight_scale;
uniform vec3 pointlight_pos;
uniform vec3 pointlight_col;
uniform float pointlight_scale;
uniform vec3 cam_pos;

in vec3 pos_ws;
in vec3 n_ws;

vec3 phong(vec3 n, vec3 l, vec3 v, vec3 I, float ns) {
	float n_dot_l = dot(l, n);
	vec3 res = vec3(0);
	if (n_dot_l > 0) {
		res += k_diff.rgb * n_dot_l * I;

		vec3 r = 2*dot(n,l)*n - l;
		res += k_spec.rgb * pow(max(0, dot(r, v)), ns) * k_spec.rgb * I;
	}
	return res;
}
// }}}
#else
// {{{
in vec3 shading;
// }}}
#endif

out vec4 out_col;


void main() {
#ifdef USE_PHONG_SHADING
	// {{{
	vec3 diff = vec3(0);
	vec3 spec = vec3(0);
	vec3 v = normalize(cam_pos - pos_ws);
	vec3 n = normalize(n_ws);
// 	n = n_ws;

	vec3 dirlight_illum = phong(n, -dirlight_dir, v, 
								dirlight_col*dirlight_scale, 4);

	vec3 to_light = pointlight_pos - pos_ws;
	float dist = length(to_light);
	to_light = normalize(to_light);
	vec3 pointlight_illum = phong(n, to_light, v, 
								  pointlight_col*pointlight_scale, 140);
	pointlight_illum /= (dist/100);

	out_col = vec4(dirlight_illum + pointlight_illum, 1);
	// }}}
#else
	// {{{
	out_col = vec4(shading,1);
	// }}}
#endif
}
