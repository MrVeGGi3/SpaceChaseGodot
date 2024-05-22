extends Control

@export var Player : Player 
@onready var hora_minutos = $HourDisplay/HoraMinutos
@onready var dia_month = $HourDisplay/DiaMonth

#Variáveis de Tempo do Game Manager
@onready var dia = GameManager.dia
@onready var mes = GameManager.mes
@onready var hora = GameManager.hora
@onready var minutos = GameManager.minutos

#Variáveis de Status do Game Manager
@onready var water = GameManager.water
@onready var o2 = GameManager.oxigen
@onready var h2 = GameManager.hidrogen
@onready var energy = GameManager.energy
@onready var metal = GameManager.metal
@onready var food = GameManager.organics

#labels
@onready var water_label = $StatusDisplay/Water
@onready var o2_label = $StatusDisplay/O2
@onready var h2_label = $StatusDisplay/H2
@onready var energy_label = $StatusDisplay/Energy
@onready var metal_label = $StatusDisplay/Metal
@onready var food_label = $StatusDisplay/Food
#variaveis do player

@onready var p_thirsty = Player.thirsty
@onready var p_hungry = Player.hungry
@onready var p_oxigen = Player.oxigen_player
@onready var p_crazyness = Player.crazyness
@onready var p_sleepy = Player.sleepy


#booleanas de controle de status
@onready var is_time_double : bool = false
@onready var is_paused : bool = false
@onready var is_time_slowed : bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	hora_minutos.text = "%02d:%02d" % [hora, minutos]
	dia_month.text = "%02d/%02d" % [dia, mes]
	water_label.text = "%d L" % [water]
	o2_label.text = "%d L" % [o2]
	h2_label.text = "%d L" % [h2]
	energy_label.text = "%d A/h" % [energy]
	metal_label.text = "%d Kg" % [metal]
	food_label.text = "%d Kg" % [food]
	
	#A amostra dos status do player serão mostrados em 4 cores diferentes:
	#Verde = Ok, Amarelo = Mais ou Menos, Vermelho = Risco, Preto = Prestes ao Game Over
	#Condições de Game Over:
	#Thirsty em Preto com mais de 3 dias
	#Hungry com mais de 7 dias
	#Oxigen com mais de 5 minutos
	#Crazyness com mais de 14 dias
	#Sleepy com mais de 10 dias
	
	#if p_oxigen <= 100 and p_oxigem >= 50:
	#   status_oxigen
	
func _on_acelerate_time_pressed():
	if not is_time_double and not is_time_slowed:
		Engine.time_scale = 2.0
		is_time_double = true
	else:
		return
		
	if is_time_double and not is_time_slowed:
		Engine.time_scale = 1.0
		is_time_double = false
	else: 
		return


func _on_pause_time_pressed():
	if not is_paused:
		get_tree().paused = true
		is_paused = true
	if is_paused:
		get_tree().paused = false
		is_paused = false
		

func _on_slow_time_pressed():
	if not is_time_slowed and not is_time_double:
		Engine.time_scale = 0.25
		is_time_slowed = true
	else:
		return
		
	if is_time_slowed and not is_time_double:
		Engine.time_scale = 1.0
		is_time_slowed = false
	else: 
		return
