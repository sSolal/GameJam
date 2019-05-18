extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector2(0,0)
var gravity = 981*2
var speed = 100#85
var jumpForce = 400
var sideJumpForce = 280
var run_speed = 1.7
var flag = false
var run = false

var anim
var current_anim = "idle"
var was_on_floor = true
# Called when the node enters the scene tree for the first time.
func _ready():
	anim = $AnimationTree.get("parameters/playback")
	anim.start("idle")
	$AnimationTree.active = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity.y+=981*delta
	velocity = move_and_slide(velocity,Vector2(0,-1))
	velocity.x = velocity.x*0.95
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
	if Input.is_action_just_pressed("ui_up"):
		
		if is_on_floor():
			$Jump.play()
			velocity.y=-jumpForce
			#anim.travel("Jump")
		elif is_on_wall():
			velocity.y=-sideJumpForce	
			velocity.x=-sign(velocity.x)*sideJumpForce
			flag = true
			
	if is_on_floor():
		if abs(velocity.x)<25:
			anim.travel("idle")
		if not was_on_floor:
			$Land.play()
			was_on_floor = true
	else:
		was_on_floor = false
		if velocity.y>12:
			anim.travel("Fall")
		
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
	$Metamorphose_moche.scale=Vector2(0.1,0.1)
	$Metamorphose_moche.visible = true
func die(msg):
	print("Died")
	get_tree().reload_current_scene()