#include "mesh.h"
#include "shader.h"
#include "context.h"

#include <iostream>
#include <glm/glm.hpp>
#include <glm/gtc/type_ptr.hpp>
#include <GL/glew.h>
#include <GL/gl.h>

using namespace std;
using namespace glm;


mat4 perspective_projection_transform(float fovy, float aspect, float n, float f) {
    // TODO: Aufgabe 1.4
	// OpenGL Projektionsmatrix
    float h = tan(fovy/2) * n;
    float w = aspect * h;
	mat4 P = mat4(
	    vec4(n/w, 0, 0, 0),
		vec4(0, n/h, 0, 0),
		vec4(0, 0, (n+f)/(n-f), -1),
		vec4(0, 0, (2*f*n)/(n-f), 0)
	);
	return P;
}

mat4 viewing_transform(const vec3 &pos, const vec3 &dir, const vec3 &up) {
    // TODO: Aufgabe 1.5
	// OpenGL Viewingmatrix
	vec3 z = normalize(-dir);
	vec3 x = normalize(cross(up, z));
	vec3 y = cross(z, x);

	mat4 V = transpose(mat4(
	    vec4(x, 0.0f),
		vec4(y, 0.0f),
		vec4(z, 0.0f),
		vec4(0, 0, 0, 1.0f)
	));
	mat4 T = mat4(
	    vec4(1, 0, 0, 0),
		vec4(0, 1, 0, 0),
		vec4(0, 0, 1, 0),
		vec4(-pos, 1.0f)
	);
	return V * T;
}

mat4 rotation_matrix(float angle, vec3 axis) {
    return glm::rotate(mat4(1), angle, axis);
}


int main() {
	ContextParameters params;
	params.gl_major = 3;
	params.gl_minor = 3;
	params.title = "CG'20 mini renderer";
	Context::init(params);

	load_mesh();
	load_shader();

	float ang = 0.0f;
	while (Context::running()) {
		glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
		glClearColor(1, 0, 0, 1);

		bind_shader();
		float aspect = float(Context::instance().vp_w) / Context::instance().vp_h;
		mat4 P = perspective_projection_transform(65, aspect, 1, 300);
		mat4 V = viewing_transform(vec3(180,0,50), vec3(-1, 0, 0), vec3(0,0,1));
		mat4 R = rotation_matrix(ang, vec3(0, 1, 0));
		glUniformMatrix4fv(uniform_location("model"), 1, GL_FALSE, glm::value_ptr(mat4(1)));
		glUniformMatrix4fv(uniform_location("view"), 1, GL_FALSE, glm::value_ptr(V));
		glUniformMatrix4fv(uniform_location("proj"), 1, GL_FALSE, glm::value_ptr(P));
		glUniformMatrix4fv(uniform_location("rotation"), 1, GL_FALSE, glm::value_ptr(R));
		draw_mesh();
		unbind_shader();

		ang += 0.01f;

		Context::swap_buffers();
	}

	cout << "All seems to be fine :)" << endl;
	return 0;
}
