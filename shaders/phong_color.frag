#version 300 es

precision mediump float;

in vec3 frag_pos;
in vec3 frag_normal;

uniform vec3 light_ambient;
uniform vec3 light_position;
uniform vec3 light_color;
uniform vec3 camera_position;
uniform vec3 material_color;      // Ka and Kd
uniform vec3 material_specular;   // Ks
uniform float material_shininess; // n

out vec4 FragColor;

void main() {

	vec3 ambient = light_ambient;

	vec3 diffuse = light_color*clamp(dot(frag_normal,normalize(light_position-frag_pos)),0.0,1.0);

	vec3 reflect_light = reflect(-normalize(light_position-frag_pos),frag_normal);
	vec3 view = normalize(camera_position-frag_pos);
	vec3 specular = light_color*pow(clamp(dot(reflect_light,view),0.0,1.0),material_shininess);
	
	
	
	
    FragColor = vec4(ambient, 1.0)*vec4(material_color, 1.0) + vec4(diffuse, 1.0)*vec4(material_color, 1.0) + vec4(specular, 1.0)*vec4(material_specular, 1.0);
	
}
