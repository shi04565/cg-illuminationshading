#version 300 es

precision highp float;

in vec3 vertex_position;
in vec3 vertex_normal;
in vec2 vertex_texcoord;

uniform int num_lights;
uniform vec3 light_ambient;
uniform vec3 light_position[10];
uniform vec3 light_color[10];
uniform vec3 camera_position;
uniform float material_shininess;
uniform vec2 texture_scale;
uniform mat4 model_matrix;
uniform mat4 view_matrix;
uniform mat4 projection_matrix;

out vec3 ambient;
out vec3 diffuse;
out vec3 specular;
out vec2 frag_texcoord;

void main() {
    gl_Position = projection_matrix * view_matrix * model_matrix * vec4(vertex_position, 1.0);
    frag_texcoord = vertex_texcoord * texture_scale;
	vec4 temp = model_matrix*vec4(vertex_position,1.0);
	vec3 vertex_positionNew = vec3(temp);
	vec3 vertice_normalNew = normalize(inverse(transpose(mat3(model_matrix)))*vertex_normal);
	
	ambient = light_ambient;
	diffuse = vec3(0,0,0);
	specular = vec3(0,0,0);
	
	for(int i=0; i<num_lights; i++) {
		diffuse = diffuse+ light_color[i]*clamp(dot(vertice_normalNew,normalize(light_position[i]-vertex_positionNew)),0.0,1.0);
		
		vec3 reflect_light = reflect(-normalize(light_position[i]-vertex_positionNew),vertice_normalNew);
		vec3 view = normalize(camera_position-vertex_positionNew);
		specular = specular+ light_color[i]*pow(clamp(dot(reflect_light,view),0.0,1.0),material_shininess);
	}
	specular = min(specular,1.0);
	diffuse = min(diffuse,1.0);
	
}
