// FRAGMENT SHADER

#version 330
uniform sampler2D texture0;

// Materials
uniform vec3 materialAmbient;
uniform vec3 materialDiffuse;
uniform vec3 materialSpecular;
uniform float shininess;

// View Matrix
uniform mat4 matrixView;

struct POINT
{
vec3 position;
vec3 diffuse;
vec3 specular;
};
uniform POINT lightPoint;

in vec4 color;
in vec2 texCoord0;
in vec4 position;
in vec3 normal;

uniform vec3 fogColour;

in float fogFactor;

out vec4 outColor;

vec4 PositionalLight(POINT light)
{
vec4 color = vec4(0, 0, 0, 0);
vec3 L = normalize(matrixView * (vec4(light.position,1)) - position).xyz;
float NdotL = dot(normal, L);
color += vec4(materialDiffuse * light.diffuse, 1) * max(NdotL, 0);
return color;
}

void main(void) 
{
  outColor = color;
  outColor += PositionalLight(lightPoint);
  outColor *= texture(texture0, texCoord0);
  outColor = mix(vec4(fogColour, 1), outColor, fogFactor);
}
