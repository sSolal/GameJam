extends CanvasLayer

# Declare member variables here. Examples:
var openoption = false
# var b = "text"
onready var options = preload("res://Scenes/Options on pause.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().paused=false
		queue_free()
	
	

func _on_Options_pressed():
	if openoption == false:
		openoption = true
		var popup = options.instance()
		add_child(popup)
	

func _on_Resume_pressed():
	get_tree().paused=false
	queue_free()
	

func _on_Restart_pressed():
	get_tree().paused=false
	get_tree().change_scene("res://Scenes/Main.tscn")


func _on_Menu_pressed():
	get_tree().change_scene("res://Scenes/Menu.tscn")
	get_tree().paused=false
