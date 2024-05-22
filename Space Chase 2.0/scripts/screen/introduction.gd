extends Control
@onready var logo_audio : AudioStreamPlayer2D = $"LogoAudio"
@onready var imagem_1 = $"Imagem 1"
@onready var imagem_2 = $"Imagem 2"
@onready var imagem_3 = $"Imagem 3"
@onready var current_logo : int = 0
@onready var time_display : int = 5
@onready var time_elapsed : int = 0
@onready var logos = []
@onready var loading_screen = "res://scenes/menu/LoadingScreen.tscn"
# Called when the node enters the scene tree for the first time.
func _ready():
	logo_audio.play()
	logos = [imagem_1, imagem_2, imagem_3]
	for i in range(logos.size()):
		if i != current_logo:
			logos[i].hide()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time_elapsed += delta
	if time_elapsed >= time_display:
		time_elapsed = 0
		logos[current_logo].hide()
		
	if current_logo < logos.size() - 1:
		current_logo += 1
		logos[current_logo].show()
		
	else:
		get_tree().change_scene_to_file(loading_screen)

	if Input.is_action_just_pressed("start") or Input.is_action_just_pressed("interagir"):
		get_tree().change_scene_to_file(loading_screen)
