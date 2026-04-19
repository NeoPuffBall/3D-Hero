#version 330

uniform mat4 matrixProjection;
uniform mat4 matrixView;
uniform vec3 material;
uniform float t;

uniform float vertPos;
uniform float transparency;

uniform sampler2D noise1,noise2;

in vec3 aVertex;
in vec3 aNormal;
in vec2 aTexCoord;

out vec4 color;

float wave(float a, float x, float y, float t){
	t *= 0.05;
	return texture(noise1,aTexCoord+vec2(x+t,y)).r * texture(noise2,aTexCoord+vec2(x-t*1.2,y+t)).r;
}

void main(void) 
{
	// Calculate the wave
	float a = 1;
	float y = wave(a, aVertex.x, aVertex.z, t);
	float d = 0.1;
	float dx = (wave(a, aVertex.x+d, aVertex.z, t) - wave(a, aVertex.x-d, aVertex.z, t)) / 2 / d;
	float dz = (wave(a, aVertex.x, aVertex.z+d, t) - wave(a, aVertex.x, aVertex.z-d, t)) / 2 / d;
	vec3 newVertex = vec3(aVertex.x, y, aVertex.z);
	vec3 newNormal = normalize(vec3(-dx, 1, -dz));

	vec4 pos = matrixProjection * matrixView * vec4((newVertex*vec3(50,3,40))+vec3(-30,vertPos,10), 1.0);

	gl_Position = pos;

	vec4 lightdir = vec4(1.0, 0.5, 1.0, 0.0);
	vec4 ambient = vec4(0.1, 0.1, 0.2, 1.0);

	vec3 N = normalize(mat3(matrixView) * newNormal);
	vec3 L = normalize(lightdir).xyz;
	float NdotL = max(dot(N, L), 0.0);
	color = vec4(material, y + transparency) * (ambient + NdotL);
}
