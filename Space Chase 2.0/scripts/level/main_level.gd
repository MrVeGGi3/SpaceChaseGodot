extends Node2D

@onready var player = get_tree().get_first_node_in_group("player")

@export_category("Level Scenes")
@onready var save_load_screen: Node2D = $SaveLoadScreen
@onready var inside_space_shuttle: Node2D = $InsideSpaceShuttle
@onready var cockpit: Node2D = $Cockpit
@onready var radar_conditions_list: Node2D = $RadarConditionsList
@onready var constructions: Control = $Constructions
@onready var sintetyzer_interface: Sintetizor = $SintetyzerInterface
@onready var studies_ui: Control = $Studies
@onready var botanics_interface: BotanicsStudiesUI = $BotanicsInterface
@onready var mechanics_interface: MechanicsStudiesUI = $MechanicsInterface
@onready var electronic_interface: ElectronicStudiesUI = $ElectronicInterface


@export_category("Manutence Ratio Adjustment")
@export var manutence_ratio_chance : float
@export var storm_destruction_ratio : float
@export var wind_destruction_ratio : float
@export var ratio : float

@export_category("Maximum Time Limit")
@export var hungry_maximum_time_ : float
@export var thirsty_maximum_time : float
@export var crazyness_maximum_time : float
@export var sleepy_maximum_time : float
@export var oxigen_maximum_time : float

@export_category("Oxygen inside/outside control")
@export var loss_oxigen_external : float
@export var loss_oxigen_internal : float
@export var gain_oxigen_internal : float

@export_category("Loss of Status per Minute")
@export var loss_hungry_per_min : float
@export var loss_thirsty_per_min : float
@export var loss_crazyness_per_min : float
@export var loss_sleepy_per_min : float

@export_category("Loss of Resources per Minute")
@export var loss_energy_per_min : float

@export_category("Counters")
var hungry_limit_counter : float
var thirsty_limit_counter : float
var crazyness_limit_counter : float
var sleepy_limit_counter : float
var oxigen_limit_counter : float

@onready var slot_index = GameManager.slot_index

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Engine.time_scale = 1.0
	GameManager.is_player_outside = true
	if save_load_screen.get_acess_type():
		_set_new_game_time_value(1, 1, 6, 0, 1)
		_set_resources_value(2800, 5000 , 300, 20, 500, 200)
	else:
		_get_save_manager_index()._load(slot_index)
	_set_maximum_time_status_limit(8040,4320,10080,480,10)
	_set_oxygen_loss_per_minute(0.27, 0.1, 5.0)
	_set_loss_status_per_minute(0.2, 0.4, 0.01, 0.06)
	_hide_UI_and_levels()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	GameManager.minutes += delta 
	if GameManager.minutes >= 60.0:
		GameManager.hour += 1
		GameManager.minutes = 0.0
	if GameManager.hour == 24:
		GameManager.day += 1
		GameManager.hour = 0
	if GameManager.day == 30:
		GameManager.month += 1
		GameManager.day = 1
		
	player.hungry -= delta * loss_hungry_per_min
	player.thirsty -= delta * loss_thirsty_per_min
	player.crazyness -= delta * loss_crazyness_per_min
	player.sleepy -= delta * loss_sleepy_per_min
	
	_see_player_place_to_oxygen_status(delta)
	_hungry_countdown_to_game_over(delta)
	_thirsty_countdown_to_game_over(delta)
	_sleepy_countdown_to_game_over(delta)
	_oxigen_countdown_to_game_over(delta)
	GameManager._set_resources_to_zero()
	
	
func _get_save_manager_index():
	if slot_index == 0:
		return save_load_screen.save_manager_1
	elif slot_index == 1:
		return save_load_screen.save_manager_2
	elif slot_index == 2:
		return save_load_screen.save_manager_3
	else:
		print("Ocorreu um erro aqui")

func _set_resources_value(water : float, oxigen : float, hidrogen : float, energy : float, metal : float, organics : float):
	GameManager.water = water
	GameManager.oxigen = oxigen
	GameManager.energy = energy
	GameManager.hidrogen = hidrogen
	GameManager.metal = metal
	GameManager.organics = organics
	
func _set_status_value(oxigen_tank : float, thirsty : float, sleepy : float, crazyness : float, hungry : float):
	player.oxigen_tank = oxigen_tank
	player.thirsty = thirsty
	player.sleepy = sleepy
	player.crazyness = crazyness
	player.hungry = hungry

func _set_new_game_time_value(month : int, day : int, hour : int, minutes : int, minute_per_second : int):
	GameManager.month = month
	GameManager.day = day
	GameManager.hour = hour
	GameManager.minutes = minutes
	GameManager.minute_per_second = minute_per_second

func _see_player_place_to_oxygen_status(delta : float):
	if GameManager.get_player_outside():
		player.oxigen_tank -= loss_oxigen_external * delta
	else:
		if player.oxigen_tank < 100:
			player.oxigen_tank += delta * gain_oxigen_internal
			GameManager.oxigen -= (loss_oxigen_internal + gain_oxigen_internal) * delta 
		else:
			player.oxigen_tank = 100.0
			GameManager.oxigen -= loss_oxigen_internal * delta 

func _hungry_countdown_to_game_over(delta : float):
	if player._get_hungry_limit():
		hungry_limit_counter += delta
		if hungry_limit_counter >= hungry_maximum_time_:
			GameOver()
	else:
		hungry_limit_counter = 0.0

func _thirsty_countdown_to_game_over(delta : float):
	if player._get_thirsty_limit():
		thirsty_limit_counter += delta
		if thirsty_limit_counter >= thirsty_maximum_time:
			GameOver()
	else:
		thirsty_limit_counter = 0.0
		
func _sleepy_countdown_to_game_over(delta : float):
	if player._get_sleepy_limit():
		sleepy_limit_counter += delta
		if sleepy_limit_counter >= sleepy_maximum_time:
			GameOver()
	else:
		sleepy_limit_counter = 0.0
	
func _oxigen_countdown_to_game_over(delta : float):
	if player._get_oxigen_limit():
		oxigen_limit_counter += delta
		if oxigen_limit_counter >= oxigen_maximum_time:
			GameOver()
	else:
		oxigen_limit_counter = 0.0

func _set_maximum_time_status_limit(hungry_limit : float, thirsty_limit : float, crazyness_limit : float, sleepy_limit : float, oxigen_limit : float):
	hungry_maximum_time_ = hungry_limit
	thirsty_maximum_time = thirsty_limit
	crazyness_maximum_time = crazyness_limit
	sleepy_maximum_time = sleepy_limit
	oxigen_maximum_time = oxigen_limit

func _set_oxygen_loss_per_minute(external : float, internal : float, g_internal : float):
	loss_oxigen_external = external
	loss_oxigen_internal = internal
	gain_oxigen_internal = g_internal

func _set_loss_status_per_minute(hungry_loss : float, thirsty_loss : float, crazyness_loss : float, sleepy_loss : float):
	loss_hungry_per_min = hungry_loss
	loss_thirsty_per_min = thirsty_loss
	loss_crazyness_per_min = crazyness_loss
	loss_sleepy_per_min = sleepy_loss
	
func GameOver():
	pass

func _get_hungry_loss_per_minute():
	return loss_hungry_per_min
func _get_sleepy_loss_per_minute():
	return loss_sleepy_per_min
func _get_crazyness_loss_per_minute():
	return loss_crazyness_per_min
func _get_loss_energy_per_minute():
	return loss_energy_per_min
func _get_thirsty_loss_per_minute():
	return loss_thirsty_per_min

func _hide_UI_and_levels():
	inside_space_shuttle.hide()
	save_load_screen.hide()
	cockpit.hide()
	radar_conditions_list.hide()
	constructions.hide()
	studies_ui.hide()
	sintetyzer_interface.hide()
	botanics_interface.hide()
	mechanics_interface.hide()
	electronic_interface.hide()
