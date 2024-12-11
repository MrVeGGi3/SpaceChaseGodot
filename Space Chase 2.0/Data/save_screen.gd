extends Node2D

@onready var save_manager_1: DataManipulator = $SaveManager
@onready var save_manager_2: DataManipulator = $SaveManager2
@onready var save_manager_3: DataManipulator = $SaveManager3

@export var is_new_game : bool

@onready var new_game_window: Window = $NewGameWindow
@onready var continue_game_window: Window = $ContinueGameWindow

var slot_index : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	new_game_window.hide()
	continue_game_window.hide()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _show_data():
	save_manager_1._showSlot(0)
	save_manager_2._showSlot(1)
	save_manager_3._showSlot(2)
	
func set_acess_type(value):
	is_new_game = value
	
func get_acess_type():
	return is_new_game


func _on_continue_game_close_requested() -> void:
	continue_game_window.hide()
func _on_new_game_close_requested() -> void:
	new_game_window.hide()


func _on_save_1_pressed() -> void:
	slot_index = 1
	if is_new_game:
		new_game_window.show()
	elif !is_new_game:
		continue_game_window.show()

func _on_save_2_pressed() -> void:
	slot_index = 2
	if is_new_game:
		new_game_window.show()
	elif !is_new_game:
		continue_game_window.show()

func _on_save_3_pressed() -> void:
	slot_index = 3
	if is_new_game:
		new_game_window.show()
	elif !is_new_game:
		continue_game_window.show()


func _on_new_game_windoow_confirm_pressed() -> void:
	pass
	
func _on_new_game_window_cancel_pressed() -> void:
	new_game_window.hide()

func _on_continue_window_confirm_pressed() -> void:
	pass # Replace with function body.

func _on_continue_window_cancel_pressed() -> void:
	continue_game_window.hide()
