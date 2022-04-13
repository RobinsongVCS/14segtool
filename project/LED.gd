extends Control

onready var material_led = preload("res://tex/segments.tres")

var bg_color
var off_color
var on_color
var bitmask

signal updated(bitmask)


func _ready():
	material_led = material_led.duplicate()
	$MarginContainer/segments.material = material_led


func _on_A_toggled(button_pressed):
	material_led.set_shader_param("A", button_pressed)
	update()

func _on_B_toggled(button_pressed):
	material_led.set_shader_param("B", button_pressed)
	update()

func _on_C_toggled(button_pressed):
	material_led.set_shader_param("C", button_pressed)
	update()

func _on_D_toggled(button_pressed):
	material_led.set_shader_param("D", button_pressed)
	update()

func _on_E_toggled(button_pressed):
	material_led.set_shader_param("E", button_pressed)
	update()

func _on_F_toggled(button_pressed):
	material_led.set_shader_param("F", button_pressed)
	update()

func _on_G1_toggled(button_pressed):
	material_led.set_shader_param("G1", button_pressed)
	update()

func _on_G2_toggled(button_pressed):
	material_led.set_shader_param("G2", button_pressed)
	update()

func _on_H_toggled(button_pressed):
	material_led.set_shader_param("H", button_pressed)
	update()

func _on_J_toggled(button_pressed):
	material_led.set_shader_param("J", button_pressed)
	update()

func _on_K_toggled(button_pressed):
	material_led.set_shader_param("K", button_pressed)
	update()

func _on_L_toggled(button_pressed):
	material_led.set_shader_param("L", button_pressed)
	update()

func _on_M_toggled(button_pressed):
	material_led.set_shader_param("M", button_pressed)
	update()

func _on_N_toggled(button_pressed):
	material_led.set_shader_param("N", button_pressed)
	update()

func _on_DP_toggled(button_pressed):
	material_led.set_shader_param("DP", button_pressed)
	update()

func update_colors():
	material.set_shader_param("bg",bg_color)
	material.set_shader_param("off",off_color)
	material_led.set_shader_param("on",on_color)

func update():
	emit_signal("updated",bitmask)
	
	
