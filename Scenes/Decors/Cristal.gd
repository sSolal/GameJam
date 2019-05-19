extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var player
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.get_name()=="Player":
			player.damage(delta*25)
