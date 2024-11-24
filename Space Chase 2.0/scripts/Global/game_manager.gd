extends Node

@export_category("Control Variables")

@export var oxigen : int #Liters
@export var hidrogen : int #Liters
@export var energy : int #A/h
@export var fuel : int #Liters
@export var metal : int  #Kg
@export var water : int #Liters
@export var organics : int #Kg

@export var Player : Player 
@onready var is_player_outside : bool = false
@onready var is_player_touching_interaction_area = false
@onready var game_type

@export_category("Game Time Adjustment")
@onready var day : int = 01
@onready var month : int = 01
@onready var hour : int = 06
@onready var minutes : int = 00

var time_elapsed: float = 0.0
var minute_per_second = 24 
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
	#if !is_player_outside and Player.oxigen_player < 100:
		#oxigen -= 10 * delta
		#Player.oxigen_player += 2 * delta
	#if !is_player_outside and Player.oxigen_player == 100:
		#oxigen -= 2 * delta
	#tempo: a cada 5 segundos, incrementa 30 min
	#time_elapsed += delta
	#var time_elapsed_in_seconds = floori(time_elapsed)
	#var seconds = time_elapsed_in_seconds % 60
	#minutos += 30 * (seconds/5)
	#hora += minutos/60 
	#dia += hora / 24
	#mes = dia/30
	
		
