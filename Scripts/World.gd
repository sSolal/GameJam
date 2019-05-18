extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var x_min = 0
var x_max = 20
var y_min = -40
var y_max = 0

var currentMeta = 0

var switched = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _process(delta):
	if Input.is_key_pressed(KEY_W):
		if not switched:
			switch(1-currentMeta)
			currentMeta = 1-currentMeta
			switched = true
	else:
		switched = false

func switch(aim):
	print("Yeah !")
	for x in range(x_min, x_max):
		for y in range(y_min, y_max):
			var tile = get_child(currentMeta).get_cell(x,y)
			get_child(currentMeta).set_cell(x,y,-1)
			get_child(aim).set_cell(x,y,tile)