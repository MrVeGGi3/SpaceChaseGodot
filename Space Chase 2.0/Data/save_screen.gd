extends Node2D

@onready var save_manager_1: DataManipulator = $SaveManager
@onready var save_manager_2: DataManipulator = $SaveManager2
@onready var save_manager_3: DataManipulator = $SaveManager3


@onready var new_game_window: Window = $NewGameWindow
@onready var continue_game_window: Window = $ContinueGameWindow
@onready var button_sound: AudioStreamPlayer = $ButtonSound
@export var buttons : MenuButtons

@onready var confirm_buttons = [$NewGameWindow/Confirm, $ContinueGameWindow/Confirm]
@onready var cancel_buttons = [$NewGameWindow/Cancel, $ContinueGameWindow/Cancel]

@onready var new_game_text: Label = $NewGameWindow/Text
@onready var continue_text: Label = $ContinueGameWindow/Text



@onready var saves_buttons = [$Save1, $Save2, $Save3]

var LoadingScreen = "res://scenes/menu/LoadingScreen.tscn"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	new_game_window.hide()
	continue_game_window.hide()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	new_game_window.title = tr("NEW_GAME_BUTTON")
	continue_game_window.title = tr("LOAD_GAME")
	set_cancel_buttons_language()
	set_confirm_buttons_language()	
	new_game_text.text = tr("CONFIRM_NEW_GAME")
	continue_text.text = tr("I_LOAD_GAME")


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.keycode == KEY_ESCAPE and event.is_pressed:
			if visible:
				buttons.show()
				buttons.activate_options_buttons()
				hide()
			elif new_game_window.visible or continue_game_window.visible:
				new_game_window.hide()
				continue_game_window.hide()
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
	disable_save_button()
	_play_button_sound()
	GameManager.slot_index = 0
	_window_management()
func _on_save_2_pressed() -> void:
	disable_save_button()
	_play_button_sound()
	GameManager.slot_index = 1
	_window_management()
func _on_save_3_pressed() -> void:
	disable_save_button()
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
	activate_save_button()
	_play_button_sound()
	new_game_window.hide()

func _on_continue_window_confirm_pressed() -> void:
	_play_button_sound()
	get_tree().change_scene_to_file(LoadingScreen)

func _on_continue_window_cancel_pressed() -> void:
	_play_button_sound()
	activate_save_button()
	continue_game_window.hide()

func _play_button_sound() -> void:
	button_sound.play()

func disable_save_button():
	for button in saves_buttons:
		button.disabled = true

func activate_save_button():
	for button in saves_buttons:
		button.disabled = false

func set_confirm_buttons_language():
	for button in confirm_buttons:
		button.text = tr("YES_WINDOW_CONFIRM")

func set_cancel_buttons_language():
	for button in cancel_buttons:
		button.text = tr("NO_WINDOW_CONFIRM")
