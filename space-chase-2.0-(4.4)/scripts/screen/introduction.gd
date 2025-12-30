extends Control
@onready var logo_audio : AudioStreamPlayer2D = $"LogoAudio"
const MENU = "res://scenes/menu/menu.tscn"
var languages = ["en", "pt_BR", "cmn", "es"]
# Called when the node enters the scene tree for the first time.
func _ready():
	logo_audio.play()
	set_main_language()
	
func _on_timer_timeout():
	get_tree().change_scene_to_file(MENU)


func set_main_language():
	var language_matched = false
	var actual_language = OS.get_locale_language()
	for language in languages:
		if language == actual_language:
			language_matched = true
			break
		else:
			continue
	if not language_matched:
		if actual_language == "pt":
			TranslationServer.set_locale("pt_BR")
		else:
			TranslationServer.set_locale("en")
