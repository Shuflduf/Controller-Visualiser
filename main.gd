extends Control

@onready var buttons: Control = %Buttons
@onready var joysticks: Control = $Joysticks
@onready var advanced_view: VBoxContainer = $AdvancedView
@onready var buttons_view: VBoxContainer = $AdvancedView/Buttons

@export_file("*.tscn") var button_entry: String
@export var stick_mult = 10

func _input(event: InputEvent) -> void:
	if event is InputEventJoypadButton:
		buttons.get_child(event.button_index).visible = event.pressed
		for i in buttons_view.get_children():
			if i.name == str(event.button_index):
				return
		var new_entry = load(button_entry).instantiate()
		new_entry.name = str(event.button_index)
		buttons_view.add_child(new_entry)
	
	elif event is InputEventJoypadMotion:
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
	
	else: return
	
