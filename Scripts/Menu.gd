extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Start_pressed():
	get_tree().change_scene("res://Scenes/Trailer.tscn")


func _on_Option_pressed():
	get_tree().change_scene("res://Scenes/Options.tscn")


func _on_Train_pressed():
	get_tree().change_scene("res://Scenes/Tuto.tscn")


func _on_Credits_pressed():
	get_tree().change_scene("res://Scenes/Credits.tscn")
