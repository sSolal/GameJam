extends CanvasLayer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().paused=false
		queue_free()
	



func _on_Options_pressed():
	get_tree().paused=false
	get_tree().change_scene("res://Scenes/Options.tscn")


func _on_Resume_pressed():
	
	get_tree().paused=false
	queue_free()
	

func _on_Restart_pressed():
	get_tree().paused=false
	get_tree().change_scene("res://Scenes/Main.tscn")
