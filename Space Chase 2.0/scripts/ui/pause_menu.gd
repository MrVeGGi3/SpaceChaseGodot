extends Control
@onready var go_main_menu_window: Window = $GoMainMenuWindow

@export var save_manager : SaveLoadMainGame
@export var constructions_build : Control
@export var status_ui : Control

@onready var save_game: Button = $SaveGame
@onready var load_game: Button = $LoadGame
@onready var main_menu: Button = $MainMenu
@onready var back_game: Button = $BackGame
@onready var pause_title_label: Label = $PauseTitleLabel



var no_ui_open = true
const MENU = "res://scenes/menu/menu.tscn"
	

func _ready() -> void:
	go_main_menu_window.hide()
	

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.keycode == KEY_ESCAPE and event.pressed:
			GameManager.is_paused = !GameManager.is_paused
			
func _process(delta: float) -> void:
	if GameManager.is_paused:
		show()
		status_ui.hide()
		get_tree().paused = true
	elif not GameManager.is_paused:
		hide()
		status_ui.show()
		get_tree().paused = false
	
	save_game.text = tr("SAVE_GAME")
	load_game.text = tr("LOAD_GAME")
	main_menu.text = tr("MAIN_MENU")
	back_game.text = tr("BACK_GAME")
	pause_title_label.text = tr("PAUSE")

func _on_back_game_pressed() -> void:
	GameManager.is_paused = false

func _on_main_menu_pressed() -> void:
	go_main_menu_window.show()

func _on_no_pressed() -> void:
	go_main_menu_window.hide()


func _on_save_game_pressed() -> void:
	save_manager.hide_pause_menu()
	save_manager.show()
	save_manager.save_or_load = "Save"

func _on_load_game_pressed() -> void:
	save_manager.hide_pause_menu()
	save_manager.show()
	save_manager.save_or_load = "Load"


func _on_yes_pressed() -> void:
	get_tree().change_scene_to_file(MENU)
