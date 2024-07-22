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
		for i in buttons_view.get_children().size():
			if buttons_view.get_children()[i].name == str(event.button_index):
				update_entry(i, event.pressed)
				return
		var new_entry = load(button_entry).instantiate()
		new_entry.name = str(event.button_index)
		buttons_view.add_child(new_entry)
		buttons_view.get_child(-1).keycode.text = str(event.button_index)
		sort_children()
	
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

func update_entry(idx, info):
	buttons_view.get_child(idx).info.text = str(info)

func sort_children():
	var children = buttons_view.get_children()
	children.sort_custom(func(a, b): return (a.name.to_int()) < (b.name.to_int()))
	for i in range(children.size()):
		buttons_view.move_child(children[i], i)
