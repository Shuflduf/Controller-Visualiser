extends Control

@onready var pressed_buttons: Control = $PressedButtons

func _input(event: InputEvent) -> void:
	if event is InputEventJoypadButton:
		pressed_buttons.get_child(event.button_index).visible = event.pressed
