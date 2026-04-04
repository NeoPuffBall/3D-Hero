// VERTEX SHADER

#version 330

uniform mat4 matrixProjection;
uniform mat4 matrixView;
uniform mat4 matrixModelView;

// Materials
uniform vec3 materialAmbient;
uniform vec3 materialDiffuse;
uniform vec3 materialSpecular;
uniform float shininess;

in vec3 aVertex;
in vec3 aNormal;

out vec4 color;
vec4 position;
vec3 normal;

struct DIRECTIONAL
{
vec3 direction;
vec3 diffuse;
};
uniform DIRECTIONAL lightDir;

vec4 DirectionalLight(DIRECTIONAL light)
{
// Calculate Directional Light
vec4 color = vec4(0, 0, 0, 0);
vec3 L = normalize(mat3(matrixView) * light.direction);
float NdotL = dot(normal, L);
color += vec4(materialDiffuse * light.diffuse, 1) * max(NdotL, 0);
return color;
}

void main(void) 
{
  // calculate position
position = matrixModelView * vec4(aVertex, 1.0);
gl_Position = matrixProjection * position;
normal = normalize(mat3(matrixModelView) * aNormal);

// calculate light
color = vec4(0, 0, 0, 1);
color += DirectionalLight(lightDir);
}
