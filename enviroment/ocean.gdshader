shader_type spatial;

uniform float resolution = 12000.0;
uniform vec3 albedo : source_color;
uniform float metallic : hint_range(0.0, 1.0) = 0.0;
uniform float roughness : hint_range(0.0, 1.0) = 0.02;
uniform vec2 center_position = vec2(0.5,0.5);
uniform sampler2D fractal;
uniform sampler2D fractal_mipmaps;
uniform bool paused = false;
uniform float time_frame;
varying float time;

vec2 round_UV(vec2 uv){
	return round(uv*resolution)/resolution;
}

void fragment(){
	float shade = round(texture(fractal,TIME/100.0+round_UV(UV)*100.0).r*2.0);
	if (paused) {shade = round(texture(fractal,time_frame/100.0+round_UV(UV)*100.0).r*2.0);}
	float dist = abs(length(center_position - UV)*40.0);
	
	if (dist > 0.3){
		shade = round(texture(fractal_mipmaps,TIME/100.0+round_UV(UV)*100.0).r*2.0);
	}
	if (shade < 0.2){
		ALBEDO = vec3(1.0);
	}
	else{
		ALBEDO = shade * albedo;
	}
	METALLIC = metallic;
	ROUGHNESS = roughness;
}

