extends Control

@onready var buttons: Control = %Buttons
@onready var joysticks: Control = $Joysticks


@onready var right_stick: TextureRect = $Joysticks/Right
@onready var left_stick: TextureRect = $Joysticks/Left

@export var stick_mult = 10

func _input(event: InputEvent) -> void:
	if event is InputEventJoypadButton:
		print(event.button_index)
		buttons.get_child(event.button_index).visible = event.pressed
	
	if event is InputEventJoypadMotion:
		print(event.axis)
		match event.axis:
			0:
				joysticks.get_child(0).position.x = event.axis_value * stick_mult
			1:
				joysticks.get_child(0).position.y = event.axis_value * stick_mult
			2:
				joysticks.get_child(1).position.x = event.axis_value * stick_mult
			3:
				joysticks.get_child(1).position.y = event.axis_value * stick_mult
				
			4:
				joysticks.get_child(2).modulate.a = event.axis_value
			5:
				joysticks.get_child(3).modulate.a = event.axis_value
