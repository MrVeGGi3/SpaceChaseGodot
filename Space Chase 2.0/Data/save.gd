class_name DataManipulator
extends Node

@onready var player : Player = get_tree().get_first_node_in_group("player")
@onready var manager : GameManager = get_tree().get_first_node_in_group("manager")

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
	var player_var ={
		"x": round(player.position.x),
		"y": round(player.position.y),
		"scene": round(player.get_current_scene()),
		"thirsty": round(player.thirsty),
		"hungry": round(player.hungry),
		"sleepy": round(player.sleepy),
		"crazyness": round(player.sleepy),
		"oxygen_tank": round(player.oxigen_player),
		"outside": round(player.is_outside),
		"speed": round(player.speed)		
	}
	var resources_var ={
		"oxygen": round(manager.oxigen),
		"hidrogen": round(manager.hidrogen),
		"energy": round(manager.energy),
		"fuel": round(manager.fuel),
		"metal": round(manager.metal),
		"water": round(manager.water),
		"organics": round(manager.organics)
	}
	
	var gametype_var={
		"type": round(manager.game_type)
	}
	var gametime_var={
		"day": round(manager.day),
		"month": round(manager.month),
		"hour": round(manager.hour),
		"minutes": round(manager.minutes)
	}
	
	var time_var={
		"t_day": round(current_time.day),
		"t_month": round(current_time.month),
		"t_year": round(current_time.year),
		"t_hour": round(current_time.hour),
		"t_minutes": round(current_time.minutes)
	}
	
	var jsonPlayerString = JSON.stringify(player_var)
	var jsonResourcesString = JSON.stringify(resources_var)
	var jsonGameType = JSON.stringify(gametime_var)
	var jsonGametimeString = JSON.stringify(gametime_var)
	var jsonTime = JSON.stringify(time_var)
	var jsonFile = FileAccess.open(slots[index], FileAccess.WRITE)
	
	jsonFile.store_line(jsonPlayerString)
	jsonFile.store_line(jsonResourcesString)
	jsonFile.store_line(jsonGameType)
	jsonFile.store_line(jsonGametimeString)
	jsonFile.store_line(jsonTime)
	
	jsonFile.close()

func _load(index):
	var jsonFile = FileAccess.open(slots[index], FileAccess.READ)
	var jsonPlayer = jsonFile.get_as_text()
	jsonFile.close()
	var worldData = JSON.parse_string(jsonPlayer)
	
	get_tree().change_scene_to_file(worldData.scene)
	
	player.position.x = worldData.x
	player.position.y = worldData.y
	player.thirsty = worldData.thirsty
	player.hungry = worldData.hungry
	player.sleepy = worldData.sleepy
	player.crazyness = worldData.crazyness
	player.oxigen_player = worldData.crazyness
	player.is_outside = worldData.outside
	player.speed = worldData.speed
	
	manager.oxygen = worldData.oxygen
	manager.hidrogen = worldData.hidrogen
	manager.energy = worldData.energy
	manager.metal = worldData.metal
	manager.water = worldData.water
	manager.organics = worldData.organics
	
	manager.game_type = worldData.type
	
	manager.day = worldData.day
	manager.hour = worldData.hour
	manager.month = worldData.month
	manager.minutes = worldData.minutes

func _showSlot(index):
	var jsonFile = FileAccess.open(slots[index], FileAccess.READ)
	var jsonPlayer = jsonFile.get_as_text()
	jsonFile.close()
	var worldData = JSON.parse_string(jsonPlayer)
	
	if worldData == null:
		for label in labels:
			label.text = str("0")
		GameTypeLabel.text = str("Não Criado")
	
	DateLabel.text = str("%d-%02-%02" % [worldData.t_year, worldData.t_month, worldData.t_day])
	HourLabel.text = str("%02:%02" % [worldData.t_hour, worldData.t_minutes])
	o2Label.text = str(worldData.oxygen)
	H2Label.text = str(worldData.hidrogen)
	EnergyLabel.text = str(worldData.energy)
	MetalLabel.text = str(worldData.metal)
	OrganicsLabel.text = str(worldData.organics)
	GameTypeLabel.text = str(worldData.type)
	WaterLabel.text = str(worldData.water)
	GameDateTimeLabel.text = str("%02-%02" % [worldData.month, worldData.day])
	GameHourTimeLabel.text = str("%02:%02" % [worldData.hour, worldData.minutes])
	
