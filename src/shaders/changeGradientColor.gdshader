shader_type canvas_item;

uniform bool use_base_texture;
uniform sampler2D replace_gradient;
uniform sampler2D target_gradient;
uniform float gradient_control : hint_range(0.0, 1.0, 0.0001);

void vertex() {
	// Called for every vertex the material is visible on.
}

vec3 changed_gradient(vec4 tex_color, vec4 gradient){ // Makes new gradient based off the original image
	//Find average of all rgb values
	float tex_average = (tex_color.r + tex_color.g + tex_color.b) / 3.;
	vec4 grayscale_tex = vec4(tex_average, tex_average, tex_average, 1);
	vec3 gradient_final = clamp(gradient.rgb + (gradient.rgb - grayscale_tex.rgb), 0, 1.);
	return gradient_final;
}

void fragment() {
	vec4 tex_color = texture(TEXTURE, UV);
	vec4 gradient_color = texture(target_gradient, UV);
	vec3 gradient_to_transition_from;
	if (!use_base_texture){ // Tints original image with "gradient to replace" without overwritting original image
		vec4 gradient_to_replace_color = texture(replace_gradient, UV);
		gradient_to_transition_from = changed_gradient(tex_color, gradient_to_replace_color);
	} else {
		gradient_to_transition_from = tex_color.rgb;
	}
	
	vec3 gradient_to_transition_to = changed_gradient(tex_color, gradient_color);
	
	//Gets distance between new gradient and previous gradient
	vec3 tex_difference = gradient_to_transition_to.rgb - gradient_to_transition_from.rgb;
	
	float t = min(gradient_control, 1); // calculates interpolation factor so that rgb values arrive at destination at the same time
	
	vec3 transition = vec3(t * tex_difference.r, t * tex_difference.g, t * tex_difference.b);
	
	COLOR.rgb = gradient_to_transition_from.rgb + transition;
}
