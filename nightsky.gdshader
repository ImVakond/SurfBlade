shader_type canvas_item;

uniform sampler2D fractal;
void fragment(){
	if (round(texture(fractal,UV).r*17.0)/10.0 < 0.5){
		COLOR.rgb = vec3(1.0);
	}
	else{
		COLOR.rgb = vec3(0.0);
	}
}