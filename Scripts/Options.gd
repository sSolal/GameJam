extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	#AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), 1)
	$VSlider.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))*3+30
	print(AudioServer.get_bus_volume_db(1))
	$CheckBox.pressed = OS.window_fullscreen

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_VSlider_value_changed(volume):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), (volume/3-30))
	if volume == 0:
		AudioServer.set_bus_mute(0,true)
	else:
		AudioServer.set_bus_mute(0,false)

func EnableFullscreen(button_pressed):
	OS.window_fullscreen = button_pressed
