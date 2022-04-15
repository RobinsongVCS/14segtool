extends TreeItem

var bitmasks = {}
var frame_number = 0
var root

func _ready():
	pass

func init(num):
	frame_number = num
	root = get_parent()
	for i in 4:
		bitmasks[i]  = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
	set_text(0, " Frame " + str(frame_number) )
	set_tooltip(0, str(bitmasks[0]) + "\n" + str(bitmasks[1]) + "\n" + str(bitmasks[2]) + "\n" + str(bitmasks[3]))
	
func update():
	set_text(0, " Frame " + str(frame_number) )
	set_tooltip(0, str(bitmasks[0]) + "\n" + str(bitmasks[1]) + "\n" + str(bitmasks[2]) + "\n" + str(bitmasks[3]) )
	

