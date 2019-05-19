extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (NodePath) var TextureProgressPath
export (NodePath) var ScoreLabel
var score
var point = 0
var world
var BarLife
var life=100
var velocity = Vector2(0,0)
var gravity = 981
var speed = 100#85
var jumpForce = 400
var sideJumpForce = 280
var run_speed = 1.7
var flag = false
var run = false
var diving = false
var swimForce = 200
var anim
var current_anim = "idle"
var was_on_floor = true
var invin = false
# Called when the node enters the scene tree for the first time.
func _ready():
	BarLife = get_node(TextureProgressPath)
	anim = $AnimationTree.get("parameters/playback")
	anim.start("idle")
	$AnimationTree.active = true
	score = get_node(ScoreLabel)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity.y+=gravity*delta
	velocity = move_and_slide(velocity,Vector2(0,-1))
	velocity.x = velocity.x*0.91
	$Body.flip_h = velocity.x<0
	
	"""if abs(velocity.x)<25:
		if $Body.animation!="idle":
			$Body.play("idle")
	elif run == true:
		$Body.play("run")
	
	else:
		$Body.play("idle")
		#pour le moment car on a pas d'anim quand il marche
	"""
	if Input.is_action_pressed("ui_left") and not flag:
		velocity.x = -speed
		if Input.is_action_pressed("ui_run"):
			run = true
			#$Body.play("run")
			#anim.travel("Run")
			velocity.x = velocity.x*run_speed
		if Input.is_action_just_released("ui_run"):
			run = false
			#$Body.play("run")
			#anim.travel("idle")
			velocity.x = velocity.x/1.7
	if Input.is_action_pressed("ui_right") and not flag:
		velocity.x = speed
		if Input.is_action_pressed("ui_run"):
			run = true
			#Body.play("run")
			#anim.travel("Run")
			velocity.x = velocity.x*run_speed
		if Input.is_action_just_released("ui_run"):
			run = false
			#$Body.play("run")
			#anim.travel("idle")
			velocity.x = velocity.x/run_speed
	if diving and Input.is_action_pressed("ui_up"):
		velocity.y=-swimForce
	if Input.is_action_just_pressed("ui_up"):
		if is_on_floor():
			$Jump.play()
			velocity.y=-jumpForce
			#anim.travel("Jump")
		elif is_on_wall():
			velocity.y=-sideJumpForce	
			velocity.x=-sign(velocity.x)*sideJumpForce
			flag = true
	var detected = $Detect.get_overlapping_bodies()
	if len(detected)!=0:
		velocity*=0.5
		if not diving :
			diving = true
			$Water.play()
			if (world.currentMeta == 0 and not (world.switching)) or (world.switching and world.aim==0):
				#print("HEYBRO")
				for h in range(1,21):
					yield(get_tree().create_timer(0.3),"timeout")
					life += -5
	else:
		diving = false
	if is_on_floor():
		if not was_on_floor:
			$Land.play()
			was_on_floor = true
	else:
		was_on_floor = false
		
	if flag == true and is_on_floor() or Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_right"):
		flag = false
	if run == true:
		run = false
	var next_anim = v_to_anim()
	if next_anim != current_anim:
		#print(next_anim)
		anim.travel(next_anim)
		current_anim = next_anim
	if position.y>1000:
		die("Vous avez quitté le connu")
	if life<=0:
		die("Plus de vie")
	if BarLife :
		BarLife.value = life
func v_to_anim():
	if is_on_floor():
		if abs(velocity.x)>=speed*run_speed:
			return "Run"
		else:
			return "idle"
	else:
		if velocity.y>20:
			return "Fall"
		else:
			return "Jump"
		
func metamorphose():
	anim.travel("Remote")
	$MetaCool.scale=Vector2(1,1)
	$MetaCool.launchposition = position
	$MetaCool.visible = true
func die(msg):
	global.score = point
	anim.travel("Hit")
	#print("Died")
	yield(get_tree().create_timer(2),"timeout")
	get_tree().change_scene("res://Scenes/GameOver.tscn")
	
	#get_tree().reload_current_scene()
	
func hit(side, damage = 1, knockback = 8):
	if invin == false:
		invin = true
		position.x += knockback*side
		for h in range(1,21):
			yield(get_tree().create_timer(0.05),"timeout")
			life += -damage
		invin = false
		
func coinPick():
	$CoinPick.play()
	point += 100
	score.text = ("Score: "+ str(point))
	
func damage(d):
	life-=d
"""
func hitright():
	if invin == false:
		invin = true
		position.x += 8
		for h in range(1,21):
			yield(get_tree().create_timer(0.3),"timeout")
			BarLife.value += -1
		invin = false
func hitleft():
	if invin == false:
		invin = true
		position.x += -8
		for h in range(1,21):
			yield(get_tree().create_timer(0.3),"timeout")
			BarLife.value += -1
		invin = false
"""
