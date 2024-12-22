class_name Menu
extends Control

@onready var exit_window: Window = $ExitWindow
@onready var save_load_screen: Node2D = $SaveLoadScreen
@onready var menu_buttons: Control = $Buttons

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	exit_window.hide()
	save_load_screen.hide()

func _process(_delta: float) -> void:
	if save_load_screen.visible and Input.is_action_just_pressed("ui_cancel"):
		save_load_screen.hide()

func _options():
	pass

func _exit_game():
	get_tree().quit()




func _on_exit_game_pressed() -> void:
	exit_window.show()
func _on_confirm_pressed() -> void:
	_exit_game()
func _on_cancel_pressed() -> void:
	exit_window.hide()
func _on_exit_window_close_requested() -> void:
	exit_window.hide()
	
func _on_start_new_game_pressed() -> void:
	save_load_screen.set_acess_type(true)
	if save_load_screen.get_acess_type():
		save_load_screen.show()
		menu_buttons.hide()
		
func _on_continue_game_pressed() -> void:
	save_load_screen.set_acess_type(false)
	if !save_load_screen.get_acess_type():
		save_load_screen.show()
		menu_buttons.hide()
