extends Control

@export var buttons : MenuButtons
@onready var back_game: Button = $BackGame
@onready var options_title_label: Label = $OptionsTitleLabel

func _on_back_game_pressed() -> void:
	buttons.activate_options_buttons()
	hide()
	
func _process(delta: float) -> void:
	back_game.text = tr("BACK_HIDE")
	options_title_label.text = tr("OPTIONS_BUTTON")
