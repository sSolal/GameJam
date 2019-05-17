extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector2(0,0)
var gravity = 981
var speed = 100
var jumpForce = 500
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity.y+=981*delta
	velocity = move_and_slide(velocity,Vector2(0,-1))
	velocity.x = 0
	if Input.is_action_pressed("ui_left"):
		velocity.x = -speed
	if Input.is_action_pressed("ui_right"):
		velocity.x = speed
	if is_on_floor() and Input.is_action_just_pressed("ui_up"):
		velocity.y=-jumpForce