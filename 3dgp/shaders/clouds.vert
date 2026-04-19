// VERTEX SHADER

#version 330

uniform mat4 matrixProjection;
uniform mat4 matrixView;
uniform vec3 material;
uniform float t;



in vec3 aVertex;
in vec3 aNormal;

out vec4 color;

float wave(float A, float x, float y, float t){
	t *= 2;
	return A * (sin(0.5f * (x * 0.2 + y * 0.7) + t * 1.0) +
	sin(0.5f * (x * 0.7 + y * 0.2) + t * 0.8) +
	pow(sin(0.5f * (x * 0.6 + y * 0.5) + t * 1.2), 2) +
	pow(sin(0.5f * (x * 0.8 + y * 0.2) - t * 1.1), 2));
}

void main(void) 
{
	// Calculate the wave
	float a = 1;
	float y = wave(a, aVertex.x, aVertex.z, t);
	float d = 0.05;
	float dx = (wave(a, aVertex.x+d, aVertex.z, t) - wave(a, aVertex.x-d, aVertex.z, t)) / 2 / d;
	float dz = (wave(a, aVertex.x, aVertex.z+d, t) - wave(a, aVertex.x, aVertex.z-d, t)) / 2 / d;
	vec3 newVertex = vec3(aVertex.x, y, aVertex.z);
	vec3 newNormal = normalize(vec3(-dx, 1, -dz));

	vec4 pos = matrixProjection * matrixView * vec4(newVertex, 1.0);

	gl_Position = pos;

	vec4 lightdir = vec4(1.0, 0.5, 1.0, 0.0);
	vec4 ambient = vec4(0.1, 0.1, 0.2, 1.0);

	vec3 N = normalize(mat3(matrixView) * newNormal);
	vec3 L = normalize(lightdir).xyz;
	float NdotL = max(dot(N, L), 0.0);
	color = vec4(material, 1) * (ambient + NdotL);
}
