#version 300 es

precision highp float;

in vec3 vertex_position;
in vec3 vertex_normal;

uniform vec3 light_ambient;
uniform vec3 light_position;
uniform vec3 light_color;
uniform vec3 camera_position;
uniform float material_shininess; // n
uniform mat4 model_matrix;
uniform mat4 view_matrix;
uniform mat4 projection_matrix;

out vec3 ambient;
out vec3 diffuse;
out vec3 specular;

void main() {
    gl_Position = projection_matrix * view_matrix * model_matrix * vec4(vertex_position, 1.0);
	vec4 temp = vec4(vertex_position,1.0)*model_matrix;
	vec3 vertex_positionNew = vec3(temp);
	
	ambient = light_ambient;

	diffuse = light_color*clamp(dot(vertex_normal , normalize(light_position-vertex_positionNew)),0.0,1.0);

	vec3 reflect_light =reflect(-(light_position-vertex_positionNew),vertex_normal);
	vec3 view = normalize(camera_position-vertex_positionNew);
	specular = light_color*pow(max(dot(reflect_light,view),0.0),material_shininess);
}
