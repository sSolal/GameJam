extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var text = """Dans un futur lointain, en orbite autour de Butters, 
un Butterlarva qui n'arrivait pas à se métamorphoser en Butterfly
reçoit l'aide du ButterBoss. Il lui confie un objet d'une puissance
phénoménale lui permettant de métamorphoser
intégralement son environemment."""
#var texts = ["Dans un futur lointain, alors que l'espèce humaine s'est éteinte, et que la terre a été abandonnée...",
#"""Un jeune Butterlarva désespéré ne parvenient pas à se métamorphoser en Butterfly.
#Loin de se laisser abattre, il se met en quête,
#Après avoir vu partir tout ses amis,
#D'une solution pour lui aussi acquérir ses ailes, et donc sa liberté.""",
#"""De par sa perséverance, il rencontre ButterBoss,
# qui, reconnaissant les qualités morales du ButterLava,
#Lui offre un appareil hautement technologique :
#	Le MétaButter""","""Cet appareil ne lui permet pas de se métamorphoser...
#	Mais il peut désormais métamorphoser le monde autour de lui !""",
#	"""Et le voilà parti pour son ascension vers la métamorphose"""]
var e = 0
var spl = 0.05
var letter = 0
var id = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("CameraTrailer")
	var ratiox = get_viewport_rect().size.x/1024
	var ratioy = get_viewport_rect().size.y/600
	var ratio = 1/min(ratiox,ratioy)
	print(ratio)
	$Camera2D.zoom = Vector2(1,1)*ratio

func _process(delta):
	if letter<264:
		e+=delta
		if e>spl:
			e = 0
			$Camera2D/Label.text+=text[letter]
			letter+=1
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().change_scene("res://Scenes/Main.tscn")
