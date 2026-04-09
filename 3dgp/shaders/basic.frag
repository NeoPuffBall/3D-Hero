// FRAGMENT SHADER

#version 330

in vec4 color;
in vec2 texCoord0;

out vec4 outColor;

void main(void) 
{
  outColor = color;
  //outColor *= texture(texture0, texCoord0);
}
