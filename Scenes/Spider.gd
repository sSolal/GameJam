extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector2(0,0)
export (NodePath) var PlayerPath
var speed = 25
var jumpForce = 200
var player
var jump = false
# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node(PlayerPath)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity.y+=981*delta
	$AnimatedSprite.flip_h = position.x-player.position.x<0
	velocity.x = speed*(int($AnimatedSprite.flip_h)-0.5)*2
	"""if jump : 
		velocity.y = -jumpForce
		jump = false"""
	velocity = move_and_slide(velocity, Vector2(0,-1))
	"""
	jump = false"""
	var flag = false
	for i in range(get_slide_count() - 1):
			var collision = get_slide_collision(i)
			if collision.collider.name == "Player" or collision.collider.name=="SpiderWall" or "Spider" in collision.collider.name:
				flag = true
	"""if abs(velocity.x)<speed and not flag:
		jump = true"""
	if $AnimatedSprite.is_playing():
		$AnimatedSprite.stop()
	if not flag and not $AnimatedSprite.is_playing():
		$AnimatedSprite.play()
	
	
		