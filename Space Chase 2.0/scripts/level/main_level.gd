extends Node2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var save_load_screen: Node2D = $SaveLoadScreen
@onready var slot_index = GameManager.slot_index

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

@export_category("Loss of Status per Minute")
@export var loss_hungry_per_min : float
@export var loss_thirsty_per_min : float
@export var loss_crazyness_per_min : float
@export var loss_sleepy_per_min : float

@export_category("Counters")
var hungry_limit_counter : float
var thirsty_limit_counter : float
var crazyness_limit_counter : float
var sleepy_limit_counter : float
var oxigen_limit_counter : float




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Engine.time_scale = 1.0
	GameManager.is_player_outside = true
	if !save_load_screen.get_acess_type():
		_get_save_manager_index()._load(slot_index)
	elif save_load_screen.get_acess_type():
		_set_new_game_time_value(1, 1, 6, 0, 1)
	_set_resources_value(2800, 50, 300, 20, 500, 200)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	GameManager.minutes += delta 
	print(GameManager.minutes)
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
	
	if GameManager.get_player_outside():
		player.oxigen_tank -= loss_oxigen_external
	else:
		if player.oxigen_tank <= 0:
			player.oxigen_tank += delta * loss_oxigen_internal
		GameManager.oxigen -= loss_oxigen_internal * delta * 2
		
	
	if player._get_hungry_limit():
		hungry_limit_counter += delta
		if hungry_limit_counter >= hungry_maximum_time_:
			GameOver()
	else:
		hungry_limit_counter = 0.0
	
	if player._get_thirsty_limit():
		thirsty_limit_counter += delta
		if thirsty_limit_counter >= thirsty_maximum_time:
			GameOver()
	else:
		thirsty_limit_counter = 0.0
	
	if player._get_crazyness_limit():
		crazyness_limit_counter += delta
		if crazyness_limit_counter >= crazyness_maximum_time:
			GameOver()
	else:
		crazyness_limit_counter = 0.0
	
	if player._get_sleepy_limit():
		sleepy_limit_counter += delta
		if sleepy_limit_counter >= sleepy_maximum_time:
			GameOver()
	else:
		sleepy_limit_counter = 0.0
	
	if player._get_oxigen_limit():
		oxigen_limit_counter += delta
		if oxigen_limit_counter >= oxigen_maximum_time:
			GameOver()
	else:
		oxigen_limit_counter = 0.0
	
	
func _get_save_manager_index():
	if slot_index == 0:
		return save_load_screen.save_manager_1
	elif slot_index == 1:
		return save_load_screen.save_manager_2
	elif slot_index == 2:
		return save_load_screen.save_manager_3
	else:
		print("Ocorreu um erro aqui")

func _set_resources_value(w : int, o : int, h : int, e : int, m : int, org : int):
	GameManager.water = w
	GameManager.oxigen = o
	GameManager.energy = e
	GameManager.hidrogen = h
	GameManager.metal = m
	GameManager.organics = org
	
func _set_status_value(ot : int, d : int, f : int, c : int, h : int):
	player.oxigen_tank = ot
	player.thirsty = d
	player.sleepy = f
	player.crazyness = c
	player.hungry = h

func _set_new_game_time_value(month : int, day : int, hour : int, minutes : int, minute_per_second : int):
	GameManager.month = month
	GameManager.day = day
	GameManager.hour = hour
	GameManager.minutes = minutes
	GameManager.minute_per_second = minute_per_second

func GameOver():
	pass
