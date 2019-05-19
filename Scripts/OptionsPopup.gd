extends Node

# Declare member variables here. Examples:
# var a = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	resize()
	get_tree().get_root().connect("size_changed",self,"resize")
	#AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), 1)
	$Node2D/Music.value = (AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music"))+30)*2
	$Node2D/Effects.value = (AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Effects"))+30)*2
	print(AudioServer.get_bus_volume_db(1))
	$Node2D/CheckBox.pressed = OS.window_fullscreen

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func resize():
	$Node2D.position = get_tree().get_root().size/2
func EnableFullscreen(button_pressed):
	OS.window_fullscreen = button_pressed


func _on_Effects_value_changed(volume):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Effects"), (volume/2-30))
	if volume == 0:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Effects"),true)
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Effects"),false)
	if $Node2D/EffectsSound.playing == false:
		$Node2D/EffectsSound.play()



func _on_Music_value_changed(volume):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), (volume/2-30))
	if volume == 0:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"),true)
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"),false)
		

func _on_Music_mouse_entered():
	$Node2D/MusicSound.play(randf()*250)

func _on_Music_mouse_exited():
	$Node2D/MusicSound.stop()

func _on_Button_pressed():
	get_parent().openoption = false
	queue_free()
