extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("CameraTrailer")
	
	var ratiox = get_viewport_rect().size.x/1024
	var ratioy = get_viewport_rect().size.y/600
	var ratio = 1/min(ratiox,ratioy)
	print(ratio)
	$Camera2D.zoom = Vector2(1,1)*ratio



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().change_scene("res://Scenes/Main.tscn")
