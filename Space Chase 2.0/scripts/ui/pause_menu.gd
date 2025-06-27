extends Control
@onready var go_main_menu_window: Window = $GoMainMenuWindow

@export var save_manager : SaveLoadMainGame
@export var constructions_build : Control
@export var status_ui : Control


var no_ui_open = true

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


func _on_back_game_pressed() -> void:
	GameManager.is_paused = false

func _on_main_menu_pressed() -> void:
	go_main_menu_window.show()

func _on_no_pressed() -> void:
	go_main_menu_window.hide()

	
	


func _on_save_game_pressed() -> void:
	hide()
	save_manager.show()
	save_manager.save_or_load = "Save"

func _on_load_game_pressed() -> void:
	hide()
	save_manager.show()
	save_manager.save_or_load = "Load"
