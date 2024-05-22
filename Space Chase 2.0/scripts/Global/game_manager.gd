extends Node
@export_category("Control Variables")
@onready var oxigen : int = 10000 #Liters
@onready var hidrogen : int = 50 #Liters
@onready var energy : int = 300 #A/h
@onready var fuel : int = 0 #Liters
@onready var metal : int = 500 #Kg
@onready var water : int = 50 #Liters
@onready var organics : int = 30 #Kg

@export var Player : Player 
@onready var is_player_outside : bool = false

@export_category("Time Adjustment")
@onready var dia : int = 01
@onready var mes : int = 01
@onready var hora : int = 06
@onready var minutos : int = 00

var time_elapsed: float = 0.0
var minute_per_second = 24 
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !is_player_outside and Player.oxigen_player < 100:
		oxigen -= 10 * delta
		Player.oxigen_player += 2 * delta
	if !is_player_outside and Player.oxigen_player == 100:
		oxigen -= 2 * delta
	#tempo: a cada 5 segundos, incrementa 30 min
	time_elapsed += delta
	var time_elapsed_in_seconds = floori(time_elapsed)
	var seconds = time_elapsed_in_seconds % 60
	minutos += 30 * (seconds/5)
	hora += minutos/60 
	dia += hora / 24
	mes = dia/30
	
		
