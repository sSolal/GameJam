extends Camera2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (NodePath) var PlayerPath
var player
# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().get_root().connect("size_changed", self, "resize")
	resize()
	player = get_node(PlayerPath)
	
func resize():
	var ratiox = get_viewport_rect().size.x/1024
	var ratioy = get_viewport_rect().size.y/600
	var ratio = 1/max(ratiox,ratioy)
	zoom = Vector2(0.4,0.4)*ratio
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = player.position
