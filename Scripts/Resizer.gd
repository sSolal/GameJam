extends CanvasLayer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (bool) var mode = true
# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().get_root().connect("size_changed", self, "resize")
	resize()
func resize():
	var ratiox = OS.window_size.x/1024
	var ratioy = OS.window_size.y/600
	var ratio = 0
	if mode:
		ratio = max(ratiox,ratioy)
	else:
		ratio = ratioy
	scale = Vector2(1,1)*ratio