extends Control

@onready var buttons: Control = %Buttons
@onready var right_stick: TextureRect = $Joysticks/Right
@onready var left_stick: TextureRect = $Joysticks/Left

@export var stick_mult = 10

func _input(event: InputEvent) -> void:
	if event is InputEventJoypadButton:
		print(event.button_index)
		buttons.get_child(event.button_index).visible = event.pressed
	
	if event is InputEventJoypadMotion:
		match event.axis:
			0:
				left_stick.position.x = event.axis_value * stick_mult
			1:
				left_stick.position.y = event.axis_value * stick_mult
			2:
				right_stick.position.x = event.axis_value * stick_mult
			3:
				right_stick.position.y = event.axis_value * stick_mult
