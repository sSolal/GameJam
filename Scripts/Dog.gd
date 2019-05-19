extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector2(0,0)
var speed = 165
#var jumpForce = 200
var player
var jump = false
var flag = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#player = get_node(PlayerPath)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity.y+=981*delta
	if abs(player.position.x-position.x)>50 and not flag:
		$AnimatedSprite.flip_h = position.x-player.position.x<0
		velocity.x = speed*(int($AnimatedSprite.flip_h)-0.5)*2
	else:
		velocity.x = 0
	"""if jump :
		velocity.y = -jumpForce
		jump = false"""
	velocity = move_and_slide(velocity, Vector2(0,-1))
	"""
	jump = false"""
	flag = false
	for i in range(get_slide_count() - 1):
			var collision = get_slide_collision(i)
			if collision.collider.name == "Player" or collision.collider.name=="MobWalls" or "Dog" in collision.collider.name:
				flag = true
				velocity.x = 0
			if not player.invin and (position-player.position).length()<60:
				if player.position.x - position.x >0:
					player.hit(1,2,50)
				if player.position.x - position.x <0:
					player.hit(-1,2,50)
	"""if abs(velocity.x)<speed and not flag:
		jump = true"""
	if abs(velocity.x)<=20 and $AnimatedSprite.is_playing():
		$AnimatedSprite.stop()
		$AnimatedSprite.frame = 0
	if abs(velocity.x)>20 and not $AnimatedSprite.is_playing():
		$AnimatedSprite.play()
