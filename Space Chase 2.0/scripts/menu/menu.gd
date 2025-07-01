class_name Menu
extends Control

@onready var exit_window: Window = $ExitWindow
@onready var save_load_screen: Node2D = $SaveLoadScreen
@onready var menu_buttons: Control = $Buttons
@onready var options_menu: Control = $OptionsMenu
@onready var button_sound: AudioStreamPlayer = $AudioManager/ButtonSound


@export var buttons : MenuButtons


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide_UI()
func _process(_delta: float) -> void:
	if save_load_screen.visible and Input.is_action_just_pressed("ui_cancel"):
		save_load_screen.hide()

func _options():
	pass

func _exit_game():
	_play_button_sound()
	get_tree().quit()




func _on_exit_game_pressed() -> void:
	buttons.disable_options_buttons()
	_play_button_sound()
	exit_window.show()
	
func _on_confirm_pressed() -> void:
	_play_button_sound()
	_exit_game()
	
func _on_cancel_pressed() -> void:
	_play_button_sound()
	exit_window.hide()
	buttons.activate_options_buttons()
	
func _on_exit_window_close_requested() -> void:
	_play_button_sound()
	exit_window.hide()
	buttons.activate_options_buttons()
	
func _on_start_new_game_pressed() -> void:
	_play_button_sound()
	buttons.disable_options_buttons()
	save_load_screen.set_acess_type(true)
	if save_load_screen.get_acess_type():
		save_load_screen.show()
		menu_buttons.hide()
		
func _on_continue_game_pressed() -> void:
	_play_button_sound()
	buttons.disable_options_buttons()
	save_load_screen.set_acess_type(false)
	if !save_load_screen.get_acess_type():
		save_load_screen.show()
		menu_buttons.hide()



func _play_button_sound():
	button_sound.play()

func _on_options_pressed() -> void:
	buttons.disable_options_buttons()
	options_menu.show()
	
func hide_UI():
	exit_window.hide()
	save_load_screen.hide()
	options_menu.hide()
