extends Node

@export_category("Control Variables")

@export var oxigen : float #Liters
@export var hidrogen : float #Liters
@export var energy : float #A/h
@export var fuel : float #Liters
@export var metal : float  #Kg
@export var water : float #Liters
@export var organics : float #Kg

##Check if player is outside to adjust Oxigen loss
@onready var is_player_outside : bool = false
@onready var is_player_touching_interaction_area = false
##Check the Game's Difficulty
@onready var game_type
##Check Condition to win the Game
@onready var can_take_off : bool = false

@onready var can_activate_sint_ui : bool = false

@export_category("Game Time Adjustment")
@export var day : int = 1
@export var month : int = 1
@export var hour : int = 6
@export var minutes : float = 0


@export_category("Number of Constructions")
@onready var fix_robots : int = 0
@onready var hidroponics : int = 0
@onready var miner_robots : int = 0
@onready var solar_panel : int = 0

@export_category("Max Number Allowed of Constructions")
@export var max_fix_robots : int = 5 
@export var max_miner_robots : int = 5
@export var max_hidroponics : int = 5
@export var max_solar_panel : int = 5

@export_category("Booleans of Equipment Status")
var has_sint = false
var has_water_cond = false


var boost_construction : float = 1.0 
var minute_per_second : float = 1.0

@export_category("Studies Variables")
var bonus_metal_increase : float
var bonus_organic_increase : float
var bonus_electronic_increase : float


var const_status = ["Vazio", "Em Construção", "Quebrado(s)", "Em Manutenção", "Completo"]
var color_status = [Color.WHITE, Color.YELLOW, Color.RED, Color.GRAY, Color.GREEN]

@export_category("Control")
var slot_index : int
var type_game 
var is_new_game : bool
var is_paused : bool = false

func get_player_outside():
	return is_player_outside
func get_can_take_off():
	return can_take_off
	
func set_color_status(state : String):
	match state:
		"Vazio":
			return color_status[0]
		"Em Construção":
			return color_status[1]
		"Quebrado(s)":
			return color_status[2]
		"Em Manutenção":
			return color_status[3]
		"Completo":
			return color_status[4]
		_:
			return

func update_boost_construction():
	boost_construction = 1.0 + fix_robots * 5

func check_available_fix_robots():
	var robots_constructed = 0
	var fix_robots_list = get_tree().get_nodes_in_group("FixRobot")
	for robot in fix_robots_list:
		if robot.get_is_constructed():
			robots_constructed += 1
		else:
			if robots_constructed > 0:
				robots_constructed -= 1
			
	fix_robots = robots_constructed
	
	
func _process(delta: float) -> void:
	check_available_fix_robots()
	update_boost_construction()

func set_construction_status(construction_var, state : String):
	construction_var = state
