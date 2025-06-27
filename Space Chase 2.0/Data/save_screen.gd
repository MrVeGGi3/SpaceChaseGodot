extends Node2D

@onready var save_manager_1: DataManipulator = $SaveManager
@onready var save_manager_2: DataManipulator = $SaveManager2
@onready var save_manager_3: DataManipulator = $SaveManager3


@onready var new_game_window: Window = $NewGameWindow
@onready var continue_game_window: Window = $ContinueGameWindow
@onready var button_sound: AudioStreamPlayer = $ButtonSound
@export var buttons : Control

var LoadingScreen = "res://scenes/menu/LoadingScreen.tscn"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	new_game_window.hide()
	continue_game_window.hide()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.keycode == KEY_ESCAPE and event.is_pressed:
			buttons.show()
			hide()

func _show_data():
	save_manager_1._showSlot(0)
	save_manager_2._showSlot(1)
	save_manager_3._showSlot(2)
	
func set_acess_type(value):
	GameManager.is_new_game = value
	
func get_acess_type():
	return GameManager.is_new_game


func _on_continue_game_close_requested() -> void:
	continue_game_window.hide()
func _on_new_game_close_requested() -> void:
	new_game_window.hide()


func _on_save_1_pressed() -> void:
	_play_button_sound()
	GameManager.slot_index = 0
	_window_management()
func _on_save_2_pressed() -> void:
	_play_button_sound()
	GameManager.slot_index = 1
	_window_management()
func _on_save_3_pressed() -> void:
	_play_button_sound()
	GameManager.slot_index = 2
	_window_management()




func _window_management():
	if get_acess_type():
		new_game_window.show()
	elif !get_acess_type():
		continue_game_window.show()

func _on_new_game_windoow_confirm_pressed() -> void:
	button_sound.play()
	get_tree().change_scene_to_file(LoadingScreen)
	
func _on_new_game_window_cancel_pressed() -> void:
	_play_button_sound()
	new_game_window.hide()

func _on_continue_window_confirm_pressed() -> void:
	_play_button_sound()
	get_tree().change_scene_to_file(LoadingScreen)

func _on_continue_window_cancel_pressed() -> void:
	continue_game_window.hide()


func _play_button_sound() -> void:
	button_sound.play()
