class_name Timeline
extends Tree

var timer = Timer.new()

var frames = []
var playback_frame
var viewport

func _ready():
	add_child(timer)
	timer.connect("timeout", self, "play_next_frame")
	var f = .create_item()
	set_column_min_width(1,100)
	
	set_column_expand(0,true)
	set_column_expand(1,false)

func update_current_frame():
	yield(get_tree().create_timer(.15), "timeout")
	var f = get_selected()
	f.update()
	update()


func create_frame(ms: int = 100):
	var i = 0
	if get_selected():
		i = get_selected().frame_number+1
	var f = .create_item(null,i)
	f.set_script(load("res://frame_data.gd"))
	frames.append(f)
	f.viewport = viewport
	f.init(i)
	f.set_text(1,str(ms))
	update_current_frame()
	f.set_editable(1, true)

	
func remove_frame():
	var frame = get_selected()
	if frame.frame_number == 0 and frames.size()==1:
		frame.init(0)
		update_current_frame()
	else:
		var num = frame.frame_number
		frames.erase(frame)
		frame.free()
		for i in frames.size():
			frames[i].frame_number = i
			frames[i].update()
		frames[num-1].select(0)

func start_playing():
	frames[0].select(0)
	playback_frame = 0
	var time = frames[0].get_text(1).to_float()/1000
	timer.start(time)
	
func stop_playing():
	timer.stop()

func play_next_frame():
	playback_frame += 1
	if playback_frame>frames.size()-1:
		playback_frame = 0
	var time = frames[playback_frame].get_text(1).to_float()/1000
	timer.wait_time = time
	frames[playback_frame].select(0)
	
func get_drag_data(position): # begin drag
	set_drop_mode_flags(DROP_MODE_INBETWEEN)

	var preview = Label.new()
	preview.text = str(get_selected().frame_number)
	set_drag_preview(preview) # not necessary

	return get_selected() # TreeItem

func can_drop_data(position, data):
	return data is TreeItem # you shall not pass!

func drop_data(position, item): # end drag
	var to_item = get_item_at_position(position)
	if not to_item:
		return
	var shift = get_drop_section_at_position(position)
	# shift == 0 if dropping on item, -1, +1 if in between

	item.frame_number = to_item.frame_number
	to_item.frame_number += 1
	var frame = frames.pop_at(item.frame_number)
	frames.insert(to_item.frame_number, frame)
