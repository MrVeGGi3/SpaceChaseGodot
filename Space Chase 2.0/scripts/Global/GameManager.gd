extends Node

@export_category("Control Variables")

@export var oxigen : float #Liters
@export var hidrogen : float #Liters
@export var energy : float #A/h
@export var fuel : float #Liters
@export var metal : float  #Kg
@export var water : float #Liters
@export var organics : float #Kg

@onready var is_player_outside : bool = false
@onready var is_player_touching_interaction_area = false
@onready var game_type
@onready var can_take_off : bool = false

@export_category("Game Time Adjustment")
@export var day : int = 1
@export var month : int = 1
@export var hour : int = 6
@export var minutes : float = 0


@export_category("Number of Constructions")
@export var fix_robots : int = 0
@export var hidroponics : int = 0
@export var miner_robots : int = 0
@export var solar_panel : int = 0

@export_category("Max Number Allowed of Constructions")
@export var max_fix_robots : int = 5 
@export var max_miner_robots : int = 5
@export var max_hidroponics : int = 5
@export var max_solar_panel : int = 5

@export_category("Booleans of Equipment Status")
var has_sint = false
var has_water_cond = false


var minute_per_second : float = 1.0

@export_category("Variáveis de Status")
var fix_robot_status : String
var miner_robot_status : String
var hidroponics_status : String
var sintetizer_status : String
var solar_panel_status : String
var water_condenser_status : String



var const_status = ["Vazio", "Em Construção", "Quebrado(s)", "Em Manutenção", "Completo"]
var color_status = [Color.WHITE, Color.YELLOW, Color.RED, Color.GRAY,Color.GREEN]

@export_category("Control")
var slot_index : int
var type_game 
var is_new_game : bool

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
