extends Control

@onready var buttons: Control = %Buttons
@onready var joysticks: Control = $Joysticks
@onready var advanced_view: HSplitContainer = %AdvancedView

@onready var buttons_view: VBoxContainer = %ButtonsView
@onready var sticks_view: VBoxContainer = %SticksView

@export_file("*.tscn") var button_entry: String
@export var stick_mult = 10

var advanced_view_visible = false

func _input(event: InputEvent) -> void:
	if event is InputEventJoypadButton:
		buttons.get_child(event.button_index).visible = event.pressed
		for i in buttons_view.get_children().size():
			if buttons_view.get_children()[i].name == str(event.button_index):
				update_entry(buttons_view ,i, event.pressed)
				return
		var new_entry = load(button_entry).instantiate()
		new_entry.name = str(event.button_index)
		buttons_view.add_child(new_entry)
		buttons_view.get_child(-1).keycode.text = "ID: " + str(event.button_index)
		sort_children(buttons_view)
	
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
				
		for i in sticks_view.get_children().size():
			if sticks_view.get_children()[i].name == str(event.axis):
				update_entry(sticks_view, i, snapped(event.axis_value, 0.001))
				return
				
		var new_entry = load(button_entry).instantiate()
		new_entry.name = str(event.axis)
		sticks_view.add_child(new_entry)
		sticks_view.get_child(-1).keycode.text = "ID: " + str(event.axis)
		update_entry(sticks_view, -1, snapped(event.axis_value, 0.001))
		sort_children(sticks_view)
	
	elif event.is_action_pressed("tab"):
		var tween = get_tree().create_tween().set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_IN_OUT)
		if advanced_view_visible:
			tween.tween_property(advanced_view, "position:x", get_viewport_rect().size.x, 0.3)
		else:
			$Hint.hide()
			advanced_view.show()
			tween.tween_property(advanced_view, "position:x", 0, 0.3)
		advanced_view_visible = !advanced_view_visible
		await tween.finished
		advanced_view.visible = advanced_view_visible
		
	
	else: return

func update_entry(node, idx, info):
	node.get_child(idx).info.text = "Value: " + str(info)

func sort_children(node):
	var children = node.get_children()
	children.sort_custom(func(a, b): return (a.name.to_int()) < (b.name.to_int()))
	for i in range(children.size()):
		node.move_child(children[i], i)
