extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (int) var num
var player
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Image.visible:
		var bodies = get_overlapping_bodies()
		for body in bodies:
			if body.get_name()=="Player":
				player.damage(delta*50)
func switch(aim):
	if aim==num:
		$Image.show()
	else:
		$Image.hide()