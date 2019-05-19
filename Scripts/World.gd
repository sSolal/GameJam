extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal metamorphose

onready var spider_scene = preload("res://Scenes/Spider.tscn")
onready var dog_scene = preload("res://Scenes/Dog.tscn")

var x = 0
var y = 0
var r_max = 60
var visible_delay = 8

var currentMeta = 0
var aim = 0

var switching = false

export (NodePath) var PlayerPath

var player
var startTime
# Called when the node enters the scene tree for the first time.
func _ready():
	$ParallaxBackground/LAVAworld.show()
	$ParallaxBackground/WATERworld.hide()
	player = get_node(PlayerPath)
	player.world = self
	for mob in $Mobs.get_children():
			mob.player = player
	for i in $Interactive.get_children():
			i.player = player
	$Musics.get_child(0).play()
	startTime = OS.get_ticks_msec()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _process(delta):
	if Input.is_key_pressed(KEY_W):
		if not switching and not player.diving:
			switching = true
			aim = 1-currentMeta
			var pos = $Meta0.world_to_map(player.position)
			x=pos.x
			y=pos.y
			var tile = get_child(2+currentMeta).get_cell(x,y)
			#get_child(2+currentMeta).set_cell(x,y,-1)
			#get_child(2+aim).set_cell(x,y,tile)
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
		
		tile = get_child(2+currentMeta).get_cell(o,yn)
		get_child(2+currentMeta).set_cell(o,yn,-1)
		get_child(2+aim).set_cell(o,yn,tile)
		
		tile = get_child(2+currentMeta).get_cell(o,yp)
		get_child(2+currentMeta).set_cell(o,yp,-1)
		get_child(2+aim).set_cell(o,yp,tile)
	for o in range(yn,yp+1):
		tile = get_child(currentMeta).get_cell(xn,o)
		get_child(currentMeta).set_cell(xn,o,-1)
		get_child(aim).set_cell(xn,o,tile)
		
		tile = get_child(currentMeta).get_cell(xp,o)
		get_child(currentMeta).set_cell(xp,o,-1)
		get_child(aim).set_cell(xp,o,tile)
		
		tile = get_child(2+currentMeta).get_cell(xn,o)
		get_child(2+currentMeta).set_cell(xn,o,-1)
		get_child(2+aim).set_cell(xn,o,tile)
		
		tile = get_child(2+currentMeta).get_cell(xp,o)
		get_child(2+currentMeta).set_cell(xp,o,-1)
		get_child(2+aim).set_cell(xp,o,tile)
		
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
	emit_signal("metamorphose")
	$Musics/FadeOut.interpolate_property($Musics.get_child(currentMeta), "volume_db", 0, -80, 2, Tween.TRANS_LINEAR, Tween.EASE_OUT, 0)
	$Musics/FadeIn.interpolate_property($Musics.get_child(aim), "volume_db", -80, 0, 2, Tween.TRANS_LINEAR, Tween.EASE_IN, 0)
	$Musics/FadeOut.start()
	$Musics/FadeIn.start()
	#$Musics.get_child(currentMeta).stop()
	#$Musics.get_child(aim).play()
	for r in range(0,r_max):
		chunk(r)
		if r<visible_delay:
			yield(get_tree().create_timer(0.2), "timeout")
	if aim==1:
		for mob in $Mobs.get_children():
			var newdog = dog_scene.instance()
			newdog.position = mob.position
			newdog.player = player
			$Mobs.remove_child(mob)
			$Mobs.add_child(newdog)
	if aim==0:
		for mob in $Mobs.get_children():
			var newspid = spider_scene.instance()
			newspid.position = mob.position
			newspid.player = player
			$Mobs.remove_child(mob)
			$Mobs.add_child(newspid)
	if currentMeta == 0:
		$ParallaxBackground/LAVAworld.hide()
		$ParallaxBackground/WATERworld.show()
	elif currentMeta == 1:
		$ParallaxBackground/WATERworld.hide()
		$ParallaxBackground/LAVAworld.show()
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
