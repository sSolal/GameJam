extends AnimatedSprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var metaphSpeed = 5
var maxSize = 8
var launchposition
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if visible:
		scale+=Vector2(1,1)*delta*metaphSpeed
		if scale.x>maxSize:
			visible = false
		position = launchposition-get_parent().position
