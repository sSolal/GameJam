extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func _ready():
	pass

# Called when the node enters the scene tree for the first time.
func _process(delta):
	$Node2D.position.y = $Node2D.position.y-delta*50
	if $Node2D.position.y <= -850:
		get_tree().change_scene("res://Scenes/Menu.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Menu_pressed():
	get_tree().change_scene("res://Scenes/Menu.tscn")
