extends TreeItem

var bitmasks
var frame_number = -1
var img = Image.new()
var tex = ImageTexture.new()
var viewport

func _ready():
	pass


func init(num):
	frame_number = num
	bitmasks = mask()
	set_cell_mode(0,TreeItem.CELL_MODE_ICON)
	set_icon_region(0, Rect2(0,0,132,46))
	set_icon(0,tex)
	set_cell_mode(1,TreeItem.CELL_MODE_STRING)
	set_icon_max_width(0,75)
	set_text_align(1,TreeItem.ALIGN_CENTER)
	select(0)
	set_editable(1,true)
	
func update():
	img.copy_from(viewport.get_texture().get_data())
	img.flip_y()
	tex.create_from_image(img)
	set_tooltip(0, str(bitmasks[0]) + "\n" + str(bitmasks[1]) + "\n" + str(bitmasks[2]) + "\n" + str(bitmasks[3]) )
	
func mask():
	var b = {}
	for i in 4:
		b[i]  = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
	return b
