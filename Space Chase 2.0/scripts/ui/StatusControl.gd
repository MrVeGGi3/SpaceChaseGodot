extends Control

@export var player : Player
@onready var hora_minutos = $HourDisplay/HoraMinutos
@onready var dia_month = $HourDisplay/DiaMonth

#labels
@onready var water_label = $ResourcesBackground/WaterVBoxContainer/Water
@onready var o2_label = $ResourcesBackground/O2VBoxContainer/O2
@onready var h2_label = $ResourcesBackground/H2VBoxContainer/H2
@onready var energy_label = $ResourcesBackground/EnergyVBoxContainer/Energy
@onready var metal_label = $ResourcesBackground/MetalVBoxContainer/Metal
@onready var food_label = $ResourcesBackground/FoodVBoxContainer/Food

@onready var thirsty_progress_bar: ProgressBar = $StatusBackground/ThirstyVBoxContainer/ThirstyProgressBar
@onready var hungry_progress_bar: ProgressBar = $StatusBackground/HungryVBoxContainer/HungryProgressBar
@onready var oxygen_progress_bar: ProgressBar = $StatusBackground/OxygenVBoxContainer2/OxygenProgressBar
@onready var tired_progress_bar: ProgressBar = $StatusBackground/TiredVBoxContainer3/TiredProgressBar
@onready var crazyness_progress_bar: ProgressBar = $StatusBackground/CrazynessVBoxContainer4/CrazynessProgressBar
@onready var time_scale_label: Label = $TimeScaleLabel

@onready var play_time_button: Button = $GameTimeDisplayBackground/TimeDisplay/PlayTime
@onready var pause_time_button: Button = $GameTimeDisplayBackground/TimeDisplay/PauseTime
@onready var accelerate_time_button: Button = $GameTimeDisplayBackground/TimeDisplay/AccelerateTime



#booleanas de controle de status
@onready var is_paused : bool = false
@onready var is_time_slowed : bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var dia = GameManager.dia
	var mes = GameManager.mes
	var hora = GameManager.hora
	var minutos = GameManager.minutos
	
	var water = GameManager.water
	var o2 = GameManager.oxigen
	var h2 = GameManager.hidrogen
	var energy = GameManager.energy
	var metal = GameManager.metal
	var food = GameManager.organics
	
	
	hora_minutos.text = "%02d:%02d" % [hora, minutos]
	dia_month.text = "%02d/%02d" % [dia, mes]
	water_label.text = "%d L" % [water]
	o2_label.text = "%d L" % [o2]
	h2_label.text = "%d L" % [h2]
	energy_label.text = "%d A/h" % [energy]
	metal_label.text = "%d Kg" % [metal]
	food_label.text = "%d Kg" % [food]
	
	thirsty_progress_bar.value = player.thirsty
	hungry_progress_bar.value = player.hungry
	oxygen_progress_bar.value = player.oxigen_player
	tired_progress_bar.value = player.sleepy
	crazyness_progress_bar.value = player.crazyness
	
	time_scale_label.text = str("Escala de Tempo:", Engine.time_scale, " x")
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
	
	

func _on_play_time_pressed() -> void:
	if is_paused:
		Engine.time_scale = 1.0
		get_tree().paused = false
		pause_time_button.normal
		accelerate_time_button.normal
	else:
		return



func _on_pause_time_pressed() -> void:
	if !is_paused:
		get_tree().paused = true
		is_paused = true
		play_time_button.normal
		accelerate_time_button.normal
	else: 
		return
	

func _on_accelerate_time_pressed() -> void:
	if !is_paused:
		Engine.time_scale += 0.5
		pause_time_button.normal
		play_time_button.normal
	else:
		return
		
