extends Node

# Declare member variables here. Examples:
# var a = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	#AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), 1)
	$Music.value = (AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music"))+30)*2
	$Effects.value = (AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Effects"))+30)*2
	print(AudioServer.get_bus_volume_db(1))
	$CheckBox.pressed = OS.window_fullscreen

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func EnableFullscreen(button_pressed):
	OS.window_fullscreen = button_pressed


func _on_Effects_value_changed(volume):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Effects"), (volume/2-30))
	if volume == 0:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Effects"),true)
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Effects"),false)
	if $EffectsSound.playing == false:
		$EffectsSound.play()



func _on_Music_value_changed(volume):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), (volume/2-30))
	if volume == 0:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"),true)
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"),false)
		

func _on_Music_mouse_entered():
	$MusicSound.play(randf()*250)


func _on_Music_mouse_exited():
	$MusicSound.stop()