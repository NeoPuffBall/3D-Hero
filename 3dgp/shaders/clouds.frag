// FRAGMENT SHADER

#version 330

in vec4 color;
in vec4 position;
in vec3 normal;

uniform float clipping;

out vec4 outColor;

void main(void) 
{
	if (color.r < clipping)
	{
		outColor = vec4(1,1,1,0);
	}
	else
	{
		outColor = color + vec4(0.5,0.5,0.5,0);
	}
}
