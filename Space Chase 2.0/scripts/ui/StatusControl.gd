extends Control


@onready var player : Player = get_tree().get_first_node_in_group("player")
@onready var hora_minutos = $HourLabel
@onready var dia_month = $DateLabel


#labels
@onready var water_label = $ResourcesBackground/WaterVBoxContainer/Water
@onready var o2_label = $ResourcesBackground/O2VBoxContainer/O2
@onready var h2_label = $ResourcesBackground/H2VBoxContainer/H2
@onready var energy_label = $ResourcesBackground/EnergyVBoxContainer/Energy
@onready var metal_label = $ResourcesBackground/MetalVBoxContainer/Metal
@onready var food_label = $ResourcesBackground/FoodVBoxContainer/Food

@onready var thirsty_progress_bar: ProgressBar = $ThirstyVBoxContainer/ThirstyProgressBar
@onready var hungry_progress_bar: ProgressBar = $HungryVBoxContainer/HungryProgressBar
@onready var oxygen_progress_bar: ProgressBar = $OxygenVBoxContainer2/OxygenProgressBar
@onready var tired_progress_bar: ProgressBar = $TiredVBoxContainer3/TiredProgressBar
@onready var crazyness_progress_bar: ProgressBar = $CrazynessVBoxContainer4/CrazynessProgressBar
@onready var time_scale_label: Label = $TimeScaleLabel


@onready var play_time_button: Button = $GameTimeDisplayBackground/TimeDisplay/PlayTime
@onready var pause_time_button: Button = $GameTimeDisplayBackground/TimeDisplay/PauseTime
@onready var accelerate_time_button: Button = $GameTimeDisplayBackground/TimeDisplay/AccelerateTime

@export var constructions : Control
@export var studies : Control
@export var time_cons_audio_set : Node
@onready var status_animation: AnimationPlayer = $StatusAnimation




#booleanas de controle de status
@onready var is_time_slowed : bool = false

@export var studies_effect : AudioStreamPlayer
@export var cons_effect : AudioStreamPlayer
@export var time_button : AudioStreamPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):


	hora_minutos.text = "%02d:%02d" % [GameManager.hour, GameManager.minutes]
	dia_month.text = "%02d/%02d" % [GameManager.day, GameManager.month]
	water_label.text = "%d L" % [GameManager.water]
	o2_label.text = "%d L" % [GameManager.oxigen]
	h2_label.text = "%d L" % [GameManager.hidrogen]
	energy_label.text = "%d A/h" % [GameManager.energy]
	metal_label.text = "%d Kg" % [GameManager.metal]
	food_label.text = "%d Kg" % [GameManager.organics]
	
	thirsty_progress_bar.value = floori(player.thirsty)
	hungry_progress_bar.value = floori(player.hungry)
	oxygen_progress_bar.value = floori(player.oxigen_tank)
	tired_progress_bar.value = floori(player.sleepy)
	crazyness_progress_bar.value = floori(player.crazyness)
	
	time_scale_label.text = tr("TIME_SCALE") + str(Engine.time_scale, " x")
	#A amostra dos status do player serão mostrados em 4 cores diferentes:
	#Verde = Ok, Amarelo = Mais ou Menos, Vermelho = Risco, Preto = Prestes ao Game Over
	#Condições de Game Over:
	#Thirsty em Preto com mais de 3 dias
	#Hungry com mais de 7 dias
	#Oxigen com mais de 5 minutos
	#Crazyness com mais de 14 dias
	#Sleepy com mais de 10 dias

	

func _on_play_time_pressed() -> void:
	_play_time_button()
	print("Botão Play Apertado")
	get_tree().paused = false
	time_cons_audio_set.emit_signal("set_cons_audio")
	Engine.time_scale = 1.0

func _on_pause_time_pressed() -> void:
	_play_time_button()
	print("Botão Pausa Apertado")
	get_tree().paused = true
	time_cons_audio_set.emit_signal("set_cons_audio")
	Engine.time_scale = 0.0
	
func _on_accelerate_time_pressed() -> void:
	_play_time_button()
	print("Botão Acelerar Apertado")
	Engine.time_scale += 0.5
		
func _on_construction_button_pressed() -> void:
	cons_effect.play()
	constructions.show()

func _on_studies_button_pressed() -> void:
	studies_effect.play()
	studies.show()

func _play_time_button():
	time_button.play()
	
func play_status_animation(animation : String):
	status_animation.play(animation)
