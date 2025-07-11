class_name  SaveLoadMainGame
extends Node2D

@onready var save_manager_1: DataManipulator = $SaveManager
@onready var save_manager_2: DataManipulator = $SaveManager2
@onready var save_manager_3: DataManipulator = $SaveManager3

@onready var window_text: Label = $SaveLoadWindow/Text
@onready var ok_button: Button = $SaveLoadWindow/OK
@onready var confirm: Button = $SaveLoadWindow/Confirm
@onready var cancel: Button = $SaveLoadWindow/Cancel

@onready var saves_manager = [save_manager_1, save_manager_2, save_manager_3]
@onready var save_load_window: Window = $SaveLoadWindow
@onready var button_sound: AudioStreamPlayer = $ButtonSound

@onready var save_or_load : String
@export var pause_menu : Control

@onready var saves_buttons = [$Save1, $Save2, $Save3]
var index_to_save : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	save_load_window.hide()


func _unhandled_input(event: InputEvent) -> void:
	if visible:
		if event is InputEventKey:
			if event.keycode == KEY_ESCAPE and event.pressed:
				GameManager.is_paused = true
				pause_menu.show()
				activate_save_button()
				hide()


func _show_data():
	save_manager_1._showSlot(0)
	save_manager_2._showSlot(1)
	save_manager_3._showSlot(2)
	
func set_acess_type(value):
	GameManager.is_new_game = value
	
func get_acess_type():
	return GameManager.is_new_game



func _on_save_1_pressed() -> void:
	_play_button_sound()
	window_text_before()
	index_to_save = 0
func _on_save_2_pressed() -> void:
	_play_button_sound()
	window_text_before()
	index_to_save = 1
func _on_save_3_pressed() -> void:
	_play_button_sound()
	window_text_before()
	index_to_save = 2



func _play_button_sound() -> void:
	button_sound.play()


func _on_confirm_pressed() -> void:
	window_text.text = tr("WAIT_A_MOMENT")
	
	if save_or_load == "Save":
		hide_buttons_and_status()
		saves_manager[index_to_save]._save(index_to_save)
		save_load_window.title = tr("SAVING_THE_GAME")
		await get_tree().create_timer(5.0).timeout
		window_text.text = tr("SAVED_SUCESS")
		save_load_window.title = tr("SUCESS")
		saves_manager[index_to_save]._showSlot(index_to_save)
		ok_button.show()
		
	elif save_or_load == "Load":
		hide_buttons_and_status()
		save_load_window.title = tr("LOADING_THE_GAME")
		await get_tree().create_timer(5.0).timeout
		saves_manager[index_to_save]._load(index_to_save)
		window_text.text = tr("LOAD_SUCESS")
		save_load_window.title = tr("SUCESS")
		saves_manager[index_to_save]._showSlot(index_to_save)
		ok_button.show()
	
	activate_save_button()
		


func window_text_before():
	show_buttons()
	disable_save_button()
	save_load_window.show()
	save_load_window.title = tr("CONFIRM_THE_ACTION")
	window_text.text = tr("WRITE_FILE")
	ok_button.hide()
	
		

func _on_cancel_pressed() -> void:
	activate_save_button()
	save_load_window.hide()

func hide_buttons_and_status():
	confirm.hide()
	cancel.hide()

func show_buttons():
	confirm.show()
	cancel.show()


func _on_ok_pressed() -> void:
	pause_menu.show()
	save_load_window.hide()
	hide()

func disable_save_button():
	for button in saves_buttons:
		button.disabled = true

func activate_save_button():
	for button in saves_buttons:
		button.disabled = false
		
func hide_pause_menu():
	pause_menu.hide()


func _on_save_load_window_close_requested() -> void:
	save_load_window.hide()
