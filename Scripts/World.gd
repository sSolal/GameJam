extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var x_min = 0
var x_max = 50
var y_min = -50
var y_max = 0

var x = 0
var y = 0
var r_max = 25

var currentMeta = 0
var aim = 0

var switching = false

export (NodePath) var PlayerPath
var player
# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node(PlayerPath)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _process(delta):
	if Input.is_key_pressed(KEY_W):
		if not switching:
			switching = true
			aim = 1-currentMeta
			var pos = $Meta0.world_to_map(player.position)
			x=pos.x
			y=pos.y
			switch(aim)
			
func chunk(r):
	var xn = x-r
	var xp = x+r
	var yn = y-r
	var yp = y+r
	var tile
	for o in range(xn+1,xp):
		tile = get_child(currentMeta).get_cell(o,yn)
		get_child(currentMeta).set_cell(o,yn,-1)
		get_child(aim).set_cell(o,yn,tile)
		
		tile = get_child(currentMeta).get_cell(o,yp)
		get_child(currentMeta).set_cell(o,yp,-1)
		get_child(aim).set_cell(o,yp,tile)
	for o in range(yn,yp+1):
		tile = get_child(currentMeta).get_cell(xn,o)
		get_child(currentMeta).set_cell(xn,o,-1)
		get_child(aim).set_cell(xn,o,tile)
		
		tile = get_child(currentMeta).get_cell(xp,o)
		get_child(currentMeta).set_cell(xp,o,-1)
		get_child(aim).set_cell(xp,o,tile)
	r+=1
"""	
	for o in range(10):
		x+=1
		if x>=x_max:
			y+=1
			x = x_min
			if y >= y_max:
				switching = false
		var tile = get_child(currentMeta).get_cell(x,y)
		get_child(currentMeta).set_cell(x,y,-1)
		get_child(aim).set_cell(x,y,tile)"""
func switch(aim):
	for r in range(r_max):
		chunk(r)
		yield(get_tree().create_timer(0.2), "timeout")
	switching = false
	currentMeta = aim
	
	
	"""
	print("Yeah !")
	for x in range(x_min, x_max):
		for y in range(y_min, y_max):
			var tile = get_child(currentMeta).get_cell(x,y)
			get_child(currentMeta).set_cell(x,y,-1)
			get_child(aim).set_cell(x,y,tile)
			yield(get_tree(), "idle_frame")
			#yield(get_tree().create_timer(.001), "timeout")
	currentMeta = aim
	switching = false"""
