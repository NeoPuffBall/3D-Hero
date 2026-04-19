#version 330

// Input Variables (received from Vertex Shader)
in vec4 color;
in vec4 position;
in vec3 normal;
in vec2 texCoord0;

uniform sampler2D texture0;

out vec4 outColor;

void main(void) 
{
	outColor = color;
	
}
