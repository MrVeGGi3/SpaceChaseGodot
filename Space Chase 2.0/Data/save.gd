class_name DataManipulator
extends Node

@onready var player : Player = get_tree().get_first_node_in_group("player")

@export var DateLabel : Label
@export var HourLabel : Label
@export var GameDateTimeLabel: Label 
@export var GameHourTimeLabel : Label 


@export var o2Label: Label 
@export var H2Label : Label
@export var EnergyLabel : Label
@export var MetalLabel : Label
@export var OrganicsLabel : Label
@export var GameTypeLabel: Label 
@export var WaterLabel: Label 


var labels = [DateLabel, HourLabel, o2Label, H2Label, EnergyLabel, MetalLabel, OrganicsLabel, WaterLabel, GameDateTimeLabel, GameHourTimeLabel]

var slot_1 = "res://Data/slot_1.json"
var slot_2 = "res://Data/slot_2.json"
var slot_3 = "res://Data/slot_3.json"
var slots = [slot_1, slot_2, slot_3]

func _save(index):
	var current_time = Time.get_datetime_dict_from_system()
	var data = {
		"player": {
			"position": player.position,
			"thirsty": player.thirsty,
			"hungry": player.hungry,
			"sleepy": player.sleepy,
			"crazyness": player.sleepy,
			"oxygen_tank": player.oxigen_player,
			"outside": player.is_outside,
			"speed": player.speed		
		},
	 	"resources":{
			"oxygen": GameManager.oxigen,
			"hidrogen":GameManager.hidrogen,
			"energy": GameManager.energy,
			"fuel": GameManager.fuel,
			"metal": GameManager.metal,
			"water": GameManager.water,
			"organics": GameManager.organics
		},
	 	"gametype":{
			"type": GameManager.game_type
		},
	 	"gametime":{
			"day": GameManager.day,
			"month": GameManager.month,
			"hour": GameManager.hour,
			"minutes": GameManager.minutes
		},
		"time_var":{
			"t_day": current_time.day,
			"t_month": current_time.month,
			"t_year": current_time.year,
			"t_hour": current_time.hour,
			"t_minutes": current_time.minutes
		},
		}

	var jsonData = JSON.stringify(data)
	var jsonFile = FileAccess.open(slots[index], FileAccess.WRITE)
	
	jsonFile.store_line(jsonData)
	
	jsonFile.close()

func _load(index):
	var jsonFile = FileAccess.open(slots[index], FileAccess.READ)
	var jsonData = jsonFile.get_as_text()
	jsonFile.close()
	var data = JSON.parse_string(jsonData)
	
	player.position = data.player.position 
	player.thirsty = data.player.thirsty
	player.hungry = data.player.hungry
	player.sleepy = data.player.sleepy
	player.crazyness = data.player.crazyness
	player.oxigen_player = data.player.oxigen_tank
	player.is_outside = data.player.is_outside
	player.speed = data.player.speed
	
	GameManager.oxygen = data.resources.oxygen
	GameManager.hidrogen = data.resources.hidrogen
	GameManager.energy = data.resources.energy
	GameManager.metal = data.resources.metal
	GameManager.water = data.resources.water
	GameManager.organics = data.resources.organics
	
	GameManager.game_type = data.gametype.type
	
	GameManager.day = data.gametime.day
	GameManager.hour = data.gametime.hour
	GameManager.month = data.gametime.month
	GameManager.minutes = data.gametime.minutes

func _showSlot(index):
	var jsonFile = FileAccess.open(slots[index], FileAccess.READ)
	var jsonData = jsonFile.get_as_text()
	jsonFile.close()
	var data = JSON.parse_string(jsonData)
	
	if data == null:
		_clear_labels()
		return
	
	DateLabel.text = str("%d-%02-%02" % [data.time_var.t_year, data.time_var.t_month, data.time_var.t_day])
	HourLabel.text = str("%02:%02" % [data.time_var.t_hour, data.time_var.t_minutes])
	o2Label.text = str(data.resources.oxygen)
	H2Label.text = str(data.resources.hidrogen)
	EnergyLabel.text = str(data.resources.energy)
	MetalLabel.text = str(data.resources.metal)
	OrganicsLabel.text = str(data.resources.organics)
	GameTypeLabel.text = str(data.gametype.type)
	WaterLabel.text = str(data.resources.water)
	GameDateTimeLabel.text = str("%02-%02" % [data.gametime.month, data.gametime.day])
	GameHourTimeLabel.text = str("%02:%02" % [data.gametime.hour, data.gametime.minutes])
	
func _clear_labels():
	for label in [DateLabel,HourLabel, o2Label, H2Label, EnergyLabel, MetalLabel, OrganicsLabel, WaterLabel, GameDateTimeLabel, GameHourTimeLabel]:
		label.text = "0"
	GameTypeLabel.text = "Não Criado"	
