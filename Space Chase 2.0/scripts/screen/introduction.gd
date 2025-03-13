extends Control
@onready var logo_audio : AudioStreamPlayer2D = $"LogoAudio"
const MENU = "res://scenes/menu/menu.tscn"
# Called when the node enters the scene tree for the first time.
func _ready():
	logo_audio.play()
	
func _on_timer_timeout():
	get_tree().change_scene_to_file(MENU)
