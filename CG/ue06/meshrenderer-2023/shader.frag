#version 130

in vec3 vCol;
out vec4 out_color;

void main() {
    out_color = vec4(vCol, 1);
}
