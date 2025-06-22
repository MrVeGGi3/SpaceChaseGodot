extends Control

var can_place : bool = false
var can_put_here : bool = false

const CONSTRUCT_ROBOT = preload("res://scenes/constructions/ConstructionRobot.tscn")
const MINER_ROBOT = preload("res://scenes/constructions/MinerRobot.tscn")
const WATER_CONDENSER = preload("res://scenes/constructions/WaterCondenser.tscn")
const SINTETYZOR = preload("res://scenes/constructions/Sintetyzor.tscn")
const SOLAR_PANEL = preload("res://scenes/constructions/SolarPanel.tscn")
const HIDROPONICS = preload("res://scenes/constructions/Hidroponics.tscn")

var constructions_preloads = [CONSTRUCT_ROBOT, MINER_ROBOT, WATER_CONDENSER,
								HIDROPONICS, SINTETYZOR, SOLAR_PANEL]
								
var actual_item
var index

@onready var status_ui : Control
@onready var main_level : Node2D
@onready var constructions: Control 

func instantiate_construction(cons_num : int):
	var instance = constructions_preloads[cons_num].instantiate()
	index = cons_num
	actual_item = instance
	main_level.add_child(instance)
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if can_place and actual_item and can_put_here:
				actual_item.modulate = Color.WHITE
				actual_item._start_construction()
				can_place = false
				actual_item = null
				status_ui.show()
	
	if event is InputEventKey:
		if event.keycode == KEY_ESCAPE and event.pressed:
			actual_item.queue_free()
			can_place = false
			status_ui.show()
			return


func build_item(construction_number : int):
	if not can_place:
		instantiate_construction(construction_number)
		can_place = true
		disable_cons_UI()
		main_level._hide_UI_and_levels()
		


func _process(delta: float) -> void:
	if can_place and actual_item:
		actual_item.global_position = get_global_mouse_position().snapped(Vector2(32,32))
		
		var bodies = actual_item.see_bodies_around()
		var areas = actual_item.see_areas_around()
		
		if bodies.size() == 0 or areas.size() == 0:
			actual_item.modulate = Color.GREEN
			can_put_here = true
			
		elif bodies.size() > 0 or areas.size() > 0:
			actual_item.modulate = Color.RED
			can_put_here = false
		
		

func set_main_nodes_path(status_path, ml_path, constructions_path):
	status_ui = status_path
	main_level = ml_path
	constructions = constructions_path
	
func disable_cons_UI():
	status_ui.hide()
	constructions.hide()

func _add_game_manager_number(number : int):
	match number:
		1:
			GameManager.fix_robots += 1
		2:
			GameManager.miner_robots += 1
		3:
			GameManager.has_water_cond = true
		4:
			GameManager.hidroponics += 1
		5:
			GameManager.has_sint = true
		6:
			GameManager.solar_panel += 1
