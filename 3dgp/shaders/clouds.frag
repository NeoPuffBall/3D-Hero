// FRAGMENT SHADER

#version 330

in vec4 color;
in vec4 position;
in vec3 normal;

out vec4 outColor;

void main(void) 
{
  outColor = color;
}
