tool
extends ViewportContainer

onready var viewport = $Viewport
onready var led_container = $Viewport/LED_container


func _ready():
	viewport.size = led_container.rect_size
	rect_size = led_container.rect_size
