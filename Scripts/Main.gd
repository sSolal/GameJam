extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var pause = preload("res://Scenes/MenuPause.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		var popup = pause.instance()
		add_child(popup)
		get_tree().paused = true
	


func _on_Area2D_body_shape_entered(body_id, body, body_shape, area_shape):
	if body.name=="Player":
		global.score = $Player.point
		
		get_tree().change_scene("res://Scenes/Win.tscn")
