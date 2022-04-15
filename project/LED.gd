extends Control

onready var material_led = preload("res://tex/segments.tres")

var bg_color
var off_color
var on_color
var bitmask = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0] setget bm_updated

var disabled = false setget disable

func _ready():
	material_led = material_led.duplicate()
	$MarginContainer/segments.material = material_led

func disable(value):
	disabled = value
	print(disabled)
	if disabled:
		$MarginContainer/disable.mouse_filter = Control.MOUSE_FILTER_STOP
	else:
		$MarginContainer/disable.mouse_filter = Control.MOUSE_FILTER_IGNORE
		
func update_colors():
	material.set_shader_param("bg",bg_color)
	material.set_shader_param("off",off_color)
	material_led.set_shader_param("on",on_color)

#0 DP N M L K J H G2 G1 F E D C B A

func _on_A_pressed():
	if bitmask[14] == 0:
		self.bitmask[14] = 1
	else:
		self.bitmask[14] = 0 

func _on_B_pressed():
	if bitmask[13] == 0:
		self.bitmask[13] = 1
	else:
		self.bitmask[13] = 0 


func _on_C_pressed():
	if bitmask[12] == 0:
		self.bitmask[12] = 1
	else:
		self.bitmask[12] = 0 


func _on_D_pressed():
	if bitmask[11] == 0:
		self.bitmask[11] = 1
	else:
		self.bitmask[11] = 0 


func _on_E_pressed():
	if bitmask[10] == 0:
		self.bitmask[10] = 1
	else:
		self.bitmask[10] = 0 


func _on_F_pressed():
	if bitmask[9] == 0:
		self.bitmask[9] = 1
	else:
		self.bitmask[9] = 0 


func _on_G1_pressed():
	if bitmask[8] == 0:
		self.bitmask[8] = 1
	else:
		self.bitmask[8] = 0 


func _on_G2_pressed():
	if bitmask[7] == 0:
		self.bitmask[7] = 1
	else:
		self.bitmask[7] = 0 


func _on_H_pressed():
	if bitmask[6] == 0:
		self.bitmask[6] = 1
	else:
		self.bitmask[6] = 0 


func _on_J_pressed():
	if bitmask[5] == 0:
		self.bitmask[5] = 1
	else:
		self.bitmask[5] = 0 


func _on_K_pressed():
	if bitmask[4] == 0:
		self.bitmask[4] = 1
	else:
		self.bitmask[4] = 0 


func _on_L_pressed():
	if bitmask[3] == 0:
		self.bitmask[3] = 1
	else:
		self.bitmask[3] = 0 


func _on_M_pressed():
	if bitmask[2] == 0:
		self.bitmask[2] = 1
	else:
		self.bitmask[2] = 0 


func _on_N_pressed():
	if bitmask[1] == 0:
		self.bitmask[1] = 1
	else:
		self.bitmask[1] = 0 


func _on_DP_pressed():
	if bitmask[0] == 0:
		self.bitmask[0] = 1
	else:
		self.bitmask[0] = 0 

func bm_updated(value):
	bitmask = value
	#print(bitmask)
	material_led.set_shader_param("A",bitmask[14])
	material_led.set_shader_param("B",bitmask[13])
	material_led.set_shader_param("C",bitmask[12])
	material_led.set_shader_param("D",bitmask[11])
	material_led.set_shader_param("E",bitmask[10])
	material_led.set_shader_param("F",bitmask[9])
	material_led.set_shader_param("G1",bitmask[8])
	material_led.set_shader_param("G2",bitmask[7])
	material_led.set_shader_param("H",bitmask[6])
	material_led.set_shader_param("J",bitmask[5])
	material_led.set_shader_param("K",bitmask[4])
	material_led.set_shader_param("L",bitmask[3])
	material_led.set_shader_param("M",bitmask[2])
	material_led.set_shader_param("N",bitmask[1])
	material_led.set_shader_param("DP",bitmask[0])

