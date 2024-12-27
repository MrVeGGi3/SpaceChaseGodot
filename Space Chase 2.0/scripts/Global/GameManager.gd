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

@export_category("Game Time Adjustment")
@export var day : int = 1
@export var month : int = 1
@export var hour : int = 6
@export var minutes : float = 0

var minute_per_second : float = 1.0

@export_category("Control")
var slot_index : int
var type_game 
var is_new_game : bool

func get_player_outside():
	return is_player_outside

		
