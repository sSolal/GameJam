extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector2(0,0)
var gravity = 981*2
var speed = 100#85
var jumpForce = 400
var sideJumpForce = 280
var flag = false
var run = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity.y+=981*delta
	velocity = move_and_slide(velocity,Vector2(0,-1))
	velocity.x = velocity.x*0.95
	$Body.flip_h = velocity.x<0
	if abs(velocity.x)<25:
		if $Body.animation!="idle":
			$Body.play("idle")
	elif run == true:
		$Body.play("run")
	
	else:
		$Body.play("idle")
		#pour le moment car on a pas d'anim quand il marche
	
	if Input.is_action_pressed("ui_left") and not flag:
		velocity.x = -speed
		if Input.is_action_pressed("ui_run"):
			run = true
			$Body.play("run")
			velocity.x = velocity.x*1.7
		if Input.is_action_just_released("ui_run"):
			run = false
			$Body.play("run")
			velocity.x = velocity.x/1.7
	if Input.is_action_pressed("ui_right") and not flag:
		velocity.x = speed
		if Input.is_action_pressed("ui_run"):
			run = true
			$Body.play("run")
			velocity.x = velocity.x*1.7
		if Input.is_action_just_released("ui_run"):
			run = false
			$Body.play("run")
			velocity.x = velocity.x/1.7
	if Input.is_action_just_pressed("ui_up"):
		if is_on_floor():
			velocity.y=-jumpForce
		elif is_on_wall():
			velocity.y=-sideJumpForce	
			velocity.x=-sign(velocity.x)*sideJumpForce
			flag = true
	if is_on_floor() or Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_right"):
		flag = false
	if run == true:
		run = false
		