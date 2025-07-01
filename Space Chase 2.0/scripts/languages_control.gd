class_name LanguageManager
extends Control

@onready var languages_label: Label = $LanguagesLabel

func _process(delta: float) -> void:
	languages_label.text = tr("LANGUAGES_TITLE")

func _on_ptbr_pressed() -> void:
	change_language("pt_BR")

func _on_en_pressed() -> void:
	change_language("en")

func _on_ch_pressed() -> void:
	change_language("cmn")

func _on_es_pressed() -> void:
	change_language("es")

func change_language(language : String):
	TranslationServer.set_locale(language)


func _on_ru_pressed() -> void:
	change_language("ru")
