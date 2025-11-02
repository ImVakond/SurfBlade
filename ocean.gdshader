shader_type spatial;


uniform vec3 albedo : source_color;
uniform float metallic : hint_range(0.0, 1.0) = 0.0;
uniform float roughness : hint_range(0.0, 1.0) = 0.02;
uniform sampler2D fractal;
void fragment(){
	float shade = round(texture(fractal,TIME/100.0+UV * 100.0).r*2.0);
	if (shade < 0.2){
		ALBEDO = vec3(1.0);
	}
	else{
		ALBEDO = shade * albedo;
	}
	METALLIC = metallic;
	ROUGHNESS = roughness;
}