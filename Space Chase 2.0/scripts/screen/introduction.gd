extends Control
@onready var logo_audio : AudioStreamPlayer2D = $"LogoAudio"
@onready var imagem_1 = $"Imagem 1"
@onready var current_logo : int = 0
@onready var time_display : int = 5
@onready var time_elapsed : int = 0
@onready var logos = []
@onready var loading_screen = "res://scenes/menu/LoadingScreen.tscn"
# Called when the node enters the scene tree for the first time.
func _ready():
	logo_audio.play()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_timer_timeout():
	get_tree().change_scene_to_file(loading_screen)
