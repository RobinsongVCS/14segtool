extends Control

var bg_color
var off_color
var on_color

onready var alert_container = $alert_container
onready var bg_dialog = $alert_container/bg_dialog
onready var off_dialog = $alert_container/off_dialog
onready var on_dialog = $alert_container/on_dialog

onready var timeline = $Panel/CenterContainer/VBoxContainer/container/VBoxContainer/Tree

onready var bg_button = $Panel/CenterContainer/VBoxContainer/HBoxContainer/select_bg
var bg_button_style = StyleBoxFlat.new()
var bg_panel_style

onready var off_button = $Panel/CenterContainer/VBoxContainer/HBoxContainer/select_off
var off_button_style

onready var on_button = $Panel/CenterContainer/VBoxContainer/HBoxContainer/select_on
var on_button_style

onready var led1 = $Panel/CenterContainer/VBoxContainer/PanelContainer/ViewportContainer/Viewport/LED_container/LED1
onready var led2 = $Panel/CenterContainer/VBoxContainer/PanelContainer/ViewportContainer/Viewport/LED_container/LED2
onready var led3 = $Panel/CenterContainer/VBoxContainer/PanelContainer/ViewportContainer/Viewport/LED_container/LED3
onready var led4 = $Panel/CenterContainer/VBoxContainer/PanelContainer/ViewportContainer/Viewport/LED_container/LED4
onready var leds = [led1,led2,led3,led4]


onready var play_button = $Panel/CenterContainer/VBoxContainer/container/VBoxContainer/HBoxContainer/play
onready var ms = $Panel/CenterContainer/VBoxContainer/container/VBoxContainer/HBoxContainer/ms


func _ready():
	OS.center_window()
	#get_tree().root.connect("size_changed", self, "_on_viewport_size_changed")
	
	bg_button_style.corner_radius_bottom_left = 2
	bg_button_style.corner_radius_bottom_right = 2
	bg_button_style.corner_radius_top_left = 2
	bg_button_style.corner_radius_top_right = 2
	bg_panel_style = bg_button_style.duplicate()
	bg_button_style.border_color = Color.gray
	bg_button_style.border_width_bottom = 2
	bg_button_style.border_width_top = 2
	bg_button_style.border_width_left = 2
	bg_button_style.border_width_right = 2
	off_button_style = bg_button_style.duplicate()
	on_button_style = bg_button_style.duplicate()

	bg_color = Color(.01,.01,.01)
	off_color = Color(.2,.0,.0)
	on_color = Color(.9,.0,.0)
	
	bg_button_style.bg_color = bg_color
	bg_panel_style.bg_color = bg_color
	off_button_style.bg_color = off_color
	on_button_style.bg_color = on_color
	update_colors()
	
	bg_button.add_stylebox_override("normal", bg_button_style)
	off_button.add_stylebox_override("normal", off_button_style)
	on_button.add_stylebox_override("normal", on_button_style)
	
	bg_button.add_stylebox_override("hover", bg_button_style)
	off_button.add_stylebox_override("hover", off_button_style)
	on_button.add_stylebox_override("hover", on_button_style)
	
	timeline.viewport = $Panel/CenterContainer/VBoxContainer/PanelContainer/ViewportContainer/Viewport
	timeline.create_frame(ms.value)

func _on_select_bg_pressed():
	alert_container.visible = true
	$Panel/CenterContainer/VBoxContainer/PanelContainer/ViewportContainer/Viewport.gui_disable_input = true
	bg_dialog.visible = true
	bg_dialog.rect_position = Vector2(50,50)
	bg_dialog.rect_scale = Vector2(.5,.5)
	
func _on_bg_color_changed(color):
	bg_color = color
	bg_button_style.bg_color = color
	bg_panel_style.bg_color = bg_color
	bg_button.add_stylebox_override("normal", bg_button_style)
	bg_button.add_stylebox_override("hover", bg_button_style)
	$Panel/CenterContainer/VBoxContainer/PanelContainer.add_color_override("custom_styles/panel/bg_color", bg_color)
	update_colors()
	
func _on_bg_dialog_confirmed():
	$Panel/CenterContainer/VBoxContainer/PanelContainer/ViewportContainer/Viewport.gui_disable_input = false
	alert_container.visible = false

func _on_select_off_pressed():
	$Panel/CenterContainer/VBoxContainer/PanelContainer/ViewportContainer/Viewport.gui_disable_input = true
	alert_container.visible = true
	off_dialog.visible = true
	off_dialog.rect_position = Vector2(50,50)
	off_dialog.rect_scale = Vector2(.5,.5)

func _on_off_color_changed(color):
	off_color = color
	off_button_style.bg_color = color
	off_button.add_stylebox_override("normal", off_button_style)
	off_button.add_stylebox_override("hover", off_button_style)
	update_colors()
	
func _on_off_dialog_confirmed():
	$Panel/CenterContainer/VBoxContainer/PanelContainer/ViewportContainer/Viewport.gui_disable_input = false
	alert_container.visible = false

func _on_select_on_pressed():
	$Panel/CenterContainer/VBoxContainer/PanelContainer/ViewportContainer/Viewport.gui_disable_input = true
	alert_container.visible = true
	on_dialog.visible = true
	on_dialog.rect_position = Vector2(50,50)
	on_dialog.rect_scale = Vector2(.5,.5)

func _on_on_color_changed(color):
	on_color = color
	on_button_style.bg_color = color
	on_button.add_stylebox_override("normal", on_button_style)
	on_button.add_stylebox_override("hover", on_button_style)
	update_colors()

func _on_on_dialog_confirmed():
	$Panel/CenterContainer/VBoxContainer/PanelContainer/ViewportContainer/Viewport.gui_disable_input = false
	alert_container.visible = false
	
func update_colors():
	for led in leds:
		led.bg_color = bg_color
		led.off_color = off_color
		led.on_color = on_color
		led.update_colors()
		

func _on_Tree_item_selected():
	for i in 4:
		#print(leds[i].bitmask )
		leds[i].bitmask = timeline.get_selected().bitmasks[i]

func _on_LED_container_gui_input(event):
	if event is InputEventMouseButton and event.is_pressed():
		update_current_frame()

func update_current_frame():
	for i in 4:
		timeline.get_selected().bitmasks[i] = leds[i].bitmask
	timeline.update_current_frame()

func _on_add_frame_pressed():
	timeline.create_frame(ms.value)

func _on_remove_frame_pressed():
	timeline.remove_frame()

func _on_play_toggled(button_pressed):
	if button_pressed:
		play_button.text = "Stop"
		timeline.mouse_filter = Control.MOUSE_FILTER_IGNORE
		$Panel/CenterContainer/VBoxContainer/container/VBoxContainer/HBoxContainer/add_frame.disabled = true
		$Panel/CenterContainer/VBoxContainer/container/VBoxContainer/HBoxContainer/remove_frame.disabled = true
		for n in leds:
			n.disabled = true
		timeline.start_playing()
	else:
		play_button.text = "Play"
		timeline.mouse_filter = Control.MOUSE_FILTER_STOP
		$Panel/CenterContainer/VBoxContainer/container/VBoxContainer/HBoxContainer/add_frame.disabled = false
		$Panel/CenterContainer/VBoxContainer/container/VBoxContainer/HBoxContainer/remove_frame.disabled = false
		for n in leds:
			n.disabled = false
		timeline.stop_playing()
