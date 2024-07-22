extends Control

@onready var pressed_buttons: Control = %FaceButtons
@onready var right_stick: TextureRect = $Joysticks/Right

@export var stick_mult = 10

func _input(event: InputEvent) -> void:
	if event is InputEventJoypadButton:
		pressed_buttons.get_child(event.button_index).visible = event.pressed
	
	if event is InputEventJoypadMotion:
		match event.axis:
			2:
				right_stick.position.x = event.axis_value * stick_mult
			3:
				right_stick.position.y = event.axis_value * stick_mult