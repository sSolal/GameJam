extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector2(0,0)
var gravity = 981*2
var speed = 200
var jumpForce = 500
var sideJumpForce = 320
var flag = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity.y+=981*delta
	velocity = move_and_slide(velocity,Vector2(0,-1))
	velocity.x = velocity.x*0.95
	if Input.is_action_pressed("ui_left") and not flag:
		velocity.x = -speed
	if Input.is_action_pressed("ui_right") and not flag:
		velocity.x = speed
	if Input.is_action_just_pressed("ui_up"):
		if is_on_floor():
			velocity.y=-jumpForce
		elif is_on_wall():
			velocity.y=-sideJumpForce	
			velocity.x=sideJumpForce
			flag = true
	if is_on_floor() or Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_right"):
		flag = false