class_name MenuButtons
extends Control


@onready var start_new_game: Button = $StartNewGame
@onready var continue_game: Button = $ContinueGame
@onready var options: Button = $Options
@onready var exit_game: Button = $ExitGame

@onready var options_buttons = [start_new_game, continue_game, options, exit_game]

func _process(delta: float) -> void:
	start_new_game.text = tr("NEW_GAME_BUTTON")
	continue_game.text = tr("CONTINUE_BUTTON")
	options.text = tr("OPTIONS_BUTTON")
	exit_game.text = tr("EXIT_BUTTON")


func disable_options_buttons():
	for button in options_buttons:
		button.disabled = true

func activate_options_buttons():
	for button in options_buttons:
		button.disabled = false
		
