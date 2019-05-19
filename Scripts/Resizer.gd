extends CanvasLayer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().get_root().connect("size_changed", self, "resize")
	resize()
func resize():
	var ratiox = get_parent().get_viewport_rect().size.x/1024
	var ratioy = get_parent().get_viewport_rect().size.y/600
	var ratio = max(ratiox,ratioy)
	scale = Vector2(1,1)*ratio