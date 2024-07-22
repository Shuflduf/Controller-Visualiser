shader_type canvas_item;

uniform float speed = 0.5;

void fragment() {
	COLOR = texture(TEXTURE, UV + vec2(TIME * speed, 0));
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
