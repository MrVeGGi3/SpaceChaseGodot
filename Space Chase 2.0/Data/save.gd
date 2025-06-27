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

@export_category("Fix Robots Stats")
var fix_robots_pos = []
var fix_robot_time_cons = []
var fix_robot_time_to_fix = []
var fix_robot_time_to_man = []
var fix_robot_is_constructed = []
var fix_robot_is_in_construction = []
var fix_robot_is_broken = []

@export_category("Hidroponics Stats")
var hidroponics_pos = []
var hidroponics_time_cons = []
var hidroponics_time_to_fix = []
var hidroponics_time_to_man = []
var hidroponics_is_constructed = []
var hidroponics_is_in_construction = []
var hidroponics_is_broken = []
var hidroponics_organics_earnt = []

@export_category("Miner Robot Stats")
var miner_robot_pos = []
var miner_robot_time_cons = []
var miner_robot_time_to_fix = []
var miner_robot_time_to_man = []
var miner_robot_is_constructed = []
var miner_robot_is_in_construction = []
var miner_robot_is_broken = []
var miner_robot_iron_earnt = []

@export_category("Solar Panel Stats")
var solar_panel_pos = []
var solar_panel_time_cons = []
var solar_panel_time_to_fix = []
var solar_panel_time_to_man = []
var solar_panel_is_constructed = []
var solar_panel_is_in_construction = []
var solar_panel_is_broken = []

@export_category("Syntetizor Stats")
var syntetizor_pos : Vector2
var syntetizor_time_cons : float
var syntetizor_time_to_fix : float
var syntetizor_time_to_man : float
var syntetizor_is_constructed : bool
var syntetizor_is_in_construction : bool
var syntetizor_is_broken : bool


@export_category("Water Condenser Stats")
var wcondenser_pos : Vector2
var wcondenser_time_cons : float
var wcondenser_time_to_fix : float
var wcondenser_time_to_man : float
var wcondenser_water_earnt : float
var wcondenser_is_constructed : bool
var wcondenser_is_in_construction : bool
var wcondenser_is_broken : bool

@export_category("Studies Nodes")
@export var botanics_studies : BotanicsStudiesUI
@export var electronics_studies : ElectronicStudiesUI
@export var mechanics_studies : MechanicsStudiesUI

@export var main_level : Node2D

func _save(index):
	get_construction_data()
	var current_time = Time.get_datetime_dict_from_system()
	var data = {
		"player": {
			"position": {"x": player.position.x, "y": player.position.y},
			"thirsty": player.thirsty,
			"hungry": player.hungry,
			"sleepy": player.sleepy,
			"crazyness": player.crazyness,
			"oxygen_tank": player.oxigen_tank,
			"outside": GameManager.is_player_outside,
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
			"t_minutes": current_time.minute
		},
		"cons_misc" :{
			"has_syntetizor" : GameManager.has_sint,
			"construction_boost" : GameManager.boost_construction,
			"has_water_condenser" : GameManager.has_water_cond,
			"fix_robots_number" : GameManager.fix_robots,
			"hidroponics_number" : GameManager.hidroponics,
			"miner_number" : GameManager.miner_robots,
			"solar_panel_number" : GameManager.solar_panel
		},
		"studies_misc":{
			"metal_bonus" : GameManager.bonus_metal_increase,
			"electronic_bonus" : GameManager.bonus_electronic_increase,
			"organics_bonus" : GameManager.bonus_organic_increase
		},
		"fix_robot_status":{
			"positions" : fix_robots_pos,
			"time_constructed" : fix_robot_time_cons,
			"time_to_fix" : fix_robot_time_to_fix,
			"time_to_manutence" : fix_robot_time_to_man,
			"is_constructed" : fix_robot_is_constructed,
			"is_in_construction" : fix_robot_is_in_construction,
			"is_broken" : fix_robot_is_broken
		},
		"hidroponics_status" : {
			"positions" : hidroponics_pos,
			"time_constructed" : hidroponics_time_cons,
			"time_to_fix" : hidroponics_time_to_fix,
			"time_to_manutence" : hidroponics_time_to_man,
			"is_constructed" : hidroponics_is_constructed,
			"is_in_construction" : hidroponics_is_in_construction,
			"is_broken" : hidroponics_is_broken,
			"organics_earnt" : hidroponics_organics_earnt
		},
		"miner_robot_status" :{
			"positions" : miner_robot_pos,
			"time_constructed" : miner_robot_time_cons,
			"time_to_fix" : miner_robot_time_to_fix,
			"time_to_manutence" : miner_robot_time_to_man,
			"is_constructed" : miner_robot_is_constructed,
			"is_in_construction" : miner_robot_is_in_construction,
			"is_broken" : miner_robot_is_broken,
			"iron_earnt" : miner_robot_iron_earnt	
		},
		"solar_panel_status" :{
			"positions" : solar_panel_pos,
			"time_constructed" : solar_panel_time_cons,
			"time_to_fix" : solar_panel_time_to_fix,
			"time_to_manutence" : solar_panel_time_to_man,
			"is_constructed" : solar_panel_is_constructed,
			"is_in_construction" : solar_panel_is_in_construction,
			"is_broken" : solar_panel_is_broken,
		},
		"syntetizor_stats" :{
			"position" : {"x": syntetizor_pos.x, "y" : syntetizor_pos.y},
			"time_constructed" : syntetizor_time_cons,
			"time_to_fix" : syntetizor_time_to_fix,
			"time_to_manutence" : syntetizor_time_to_man,
			"is_constructed" : syntetizor_is_constructed,
			"is_in_construction" : syntetizor_is_in_construction,
			"is_broken" : syntetizor_is_broken
		},
		"water_condenser" :{
			"position" : {"x": wcondenser_pos.x, "y": wcondenser_pos.y},
			"time_constructed" : wcondenser_time_cons,
			"time_to_fix" : wcondenser_time_to_fix,
			"time_to_manutence" : wcondenser_time_to_man,
			"is_constructed" : wcondenser_is_constructed,
			"is_in_construction" : wcondenser_is_in_construction,
			"is_broken" : wcondenser_is_in_construction,
			"water_earnt" : wcondenser_water_earnt
		},
		"botanics_studies" :{
			"actual_level" : botanics_studies.actual_level,
			"actual_experience" : botanics_studies.actual_experience,
			"level_experience_to_upgrade" : botanics_studies.level_experience_upgrade,
			"current_time_focus" : botanics_studies.current_time_focus
		},
		"electronics_studies" :{
			"actual_level" : electronics_studies.actual_level,
			"actual_experience" : electronics_studies.actual_experience,
			"level_experience_to_upgrade" : electronics_studies.level_experience_upgrade,
			"current_time_focus" : electronics_studies.current_time_focus
		},
		"mechanics_studies" : {
			"actual_level" : mechanics_studies.actual_level,
			"actual_experience" : mechanics_studies.actual_experience,
			"level_experience_to_upgrade" : mechanics_studies.level_experience_upgrade,
			"current_time_focus" : mechanics_studies.current_time_focus
		} 
		}
		
		

	var jsonData = JSON.stringify(data)
	var jsonFile = FileAccess.open(slots[index], FileAccess.WRITE)
	
	jsonFile.store_line(jsonData)
	
	jsonFile.close()

func _load(index):
	destroy_constructions_before_load()
	var jsonFile = FileAccess.open(slots[index], FileAccess.READ)
	var jsonData = jsonFile.get_as_text()
	jsonFile.close()
	var data = JSON.parse_string(jsonData)
	decrypt_data(data)
	load_constructions_to_level()
	

func load_constructions_to_level():
	load_syntetizor()
	load_wcondenser()
	load_fix_robots()
	load_hidroponics()
	load_miner_robot()
	load_solar_panel()

func load_solar_panel():
	for i in range(solar_panel_pos.size()):
		var solar_instance = InstantiateConstructionsManager.SOLAR_PANEL.instantiate()
		main_level.add_child(solar_instance)
		if solar_instance.is_inside_tree():
			solar_instance.position = Vector2(solar_panel_pos[i][0], solar_panel_pos[i][1])
			solar_instance.time_constructed = float(solar_panel_time_cons[i])
			solar_instance.time_to_fix = float(solar_panel_time_to_fix[i])
			solar_instance.time_to_go_manutence = float(solar_panel_time_to_man[i])
			solar_instance.is_constructed = bool(solar_panel_is_constructed[i])
			solar_instance.is_in_construction = bool(solar_panel_is_in_construction[i])
			solar_instance.is_broken = bool(solar_panel_is_broken[i])
			solar_instance.is_instancied = true

func load_miner_robot():
	for i in range(miner_robot_pos.size()):
		var miner_instance = InstantiateConstructionsManager.MINER_ROBOT.instantiate()
		main_level.add_child(miner_instance)
		if miner_instance.is_inside_tree():
			miner_instance.position = Vector2(miner_robot_pos[i][0], miner_robot_pos[i][1])
			miner_instance.time_constructed = float(miner_robot_time_cons[i])
			miner_instance.time_to_fix = float(miner_robot_time_to_fix[i])
			miner_instance.time_to_go_manutence = float(miner_robot_time_to_man[i])
			miner_instance.is_constructed = bool(miner_robot_is_constructed[i])
			miner_instance.is_in_construction = bool(miner_robot_is_in_construction[i])
			miner_instance.is_broken = bool(miner_robot_is_broken[i])
			miner_instance.iron_earnt = float(miner_robot_iron_earnt[i])
			miner_instance.is_instancied = true
			
func load_hidroponics():
		for i in range(hidroponics_pos.size()):
			var hidroponics_instance = InstantiateConstructionsManager.HIDROPONICS.instantiate()
			main_level.add_child(hidroponics_instance)
			if hidroponics_instance.is_inside_tree():
				hidroponics_instance.position = Vector2(hidroponics_pos[i][0], hidroponics_pos[i][1])
				hidroponics_instance.time_constructed = float(hidroponics_time_cons[i])
				hidroponics_instance.time_to_fix = float(hidroponics_time_to_fix[i])
				hidroponics_instance.time_to_go_manutence = float(hidroponics_time_to_man[i])
				hidroponics_instance.is_constructed = float(hidroponics_is_constructed[i])
				hidroponics_instance.is_in_construction = bool(hidroponics_is_in_construction[i])
				hidroponics_instance.is_broken = bool(hidroponics_is_broken[i])
				hidroponics_instance.water_earnt = bool(hidroponics_organics_earnt[i])
				hidroponics_instance.is_instancied = true
func load_fix_robots():
	for i in range(fix_robots_pos.size()):
		var fix_robot_instance = InstantiateConstructionsManager.CONSTRUCT_ROBOT.instantiate()
		main_level.add_child(fix_robot_instance)
		if fix_robot_instance.is_inside_tree():
			fix_robot_instance.position = Vector2(fix_robots_pos[i][0], fix_robots_pos[i][1])
			fix_robot_instance.time_constructed = bool(fix_robot_time_cons[i])
			fix_robot_instance.time_to_fix = float(fix_robot_time_to_fix[i])
			fix_robot_instance.time_to_go_manutence = float(fix_robot_time_to_man[i])
			fix_robot_instance.is_constructed = bool(fix_robot_is_constructed[i])
			fix_robot_instance.is_in_construction = bool(fix_robot_is_in_construction[i])
			fix_robot_instance.is_broken = bool(fix_robot_is_broken[i])
			fix_robot_instance.is_instancied = true
func decrypt_data(data):
	load_player_stats(data)
	load_level_resources(data)
	load_level_misc(data)
	load_level_time(data)
	load_constructions_stats(data)
	load_construction_numbers(data)
	
func load_player_stats(data):
	player.position = Vector2(data.player.position.x, data.player.position.y)
	player.thirsty = float(data.player.thirsty)
	player.hungry = float(data.player.hungry)
	player.sleepy = float(data.player.sleepy)
	player.crazyness = float(data.player.crazyness)
	player.oxigen_tank = float(data.player.oxygen_tank)
	GameManager.is_player_outside = bool(data.player.outside)
	player.speed = float(data.player.speed)
	
func load_level_resources(data):
	GameManager.oxigen = float(data.resources.oxygen)
	GameManager.hidrogen = float(data.resources.hidrogen)
	GameManager.energy = float(data.resources.energy)
	GameManager.metal = float(data.resources.metal)
	GameManager.water = float(data.resources.water)
	GameManager.organics = float(data.resources.organics)

func load_level_misc(data):
	GameManager.game_type = str(data.gametype.type)
	GameManager.bonus_metal_increase = float(data.studies_misc.metal_bonus)
	GameManager.bonus_electronic_increase = float(data.studies_misc.electronic_bonus)
	GameManager.bonus_organic_increase = float(data.studies_misc.organics_bonus)

func load_level_time(data):
	GameManager.day = int(data.gametime.day)
	GameManager.hour = int(data.gametime.hour)
	GameManager.month = int(data.gametime.month)
	GameManager.minutes = int(data.gametime.minutes)

func load_construction_numbers(data):
	GameManager.has_sint = bool(data.cons_misc.has_syntetizor)
	GameManager.boost_construction = float(data.cons_misc.construction_boost)
	GameManager.has_water_cond = bool(data.cons_misc.has_water_condenser)
	GameManager.fix_robots = int(data.cons_misc.fix_robots_number)
	GameManager.hidroponics = int(data.cons_misc.hidroponics_number)
	GameManager.miner_robots = int(data.cons_misc.miner_number)
	GameManager.solar_panel = int(data.cons_misc.solar_panel_number)
	
func load_constructions_stats(data):
	fix_robots_pos = Array(data.fix_robot_status.positions)
	fix_robot_time_cons = Array(data.fix_robot_status.time_constructed)
	fix_robot_time_to_fix = Array(data.fix_robot_status.time_to_fix)
	fix_robot_time_to_man = Array(data.fix_robot_status.time_to_manutence)
	fix_robot_is_constructed = Array(data.fix_robot_status.is_constructed)
	fix_robot_is_in_construction = Array(data.fix_robot_status.is_in_construction)
	fix_robot_is_broken = Array(data.fix_robot_status.is_broken)
	
	hidroponics_pos = Array(data.hidroponics_status.positions)
	hidroponics_time_cons = Array(data.hidroponics_status.time_constructed)
	hidroponics_time_to_fix = Array(data.hidroponics_status.time_to_fix)
	hidroponics_time_to_man = Array(data.hidroponics_status.time_to_manutence)
	hidroponics_is_constructed = Array(data.hidroponics_status.is_constructed)
	hidroponics_is_in_construction = Array(data.hidroponics_status.is_in_construction)
	hidroponics_is_broken = Array(data.hidroponics_status.is_broken)
	hidroponics_organics_earnt = Array(data.hidroponics_status.organics_earnt)
	
	solar_panel_pos = Array(data.solar_panel_status.positions)
	solar_panel_time_cons = Array(data.solar_panel_status.time_constructed)
	solar_panel_time_to_fix = Array(data.solar_panel_status.time_to_fix)
	solar_panel_time_to_man = Array(data.solar_panel_status.time_to_manutence)
	solar_panel_is_constructed = Array(data.solar_panel_status.is_constructed)
	solar_panel_is_in_construction = Array(data.solar_panel_status.is_in_construction)
	solar_panel_is_broken = Array(data.solar_panel_status.is_broken)
	
	miner_robot_pos = Array(data.miner_robot_status.positions)
	miner_robot_time_cons = Array(data.miner_robot_status.time_constructed)
	miner_robot_time_to_fix = Array(data.miner_robot_status.time_to_fix)
	miner_robot_time_to_man = Array(data.miner_robot_status.time_to_manutence)
	miner_robot_is_constructed = Array(data.miner_robot_status.is_constructed)
	miner_robot_is_in_construction = Array(data.miner_robot_status.is_in_construction)
	miner_robot_is_broken = Array(data.miner_robot_status.is_broken)
	miner_robot_iron_earnt = Array(data.miner_robot_status.iron_earnt)
	
	wcondenser_pos = Vector2(data.water_condenser.position.x, data.water_condenser.position.y)
	wcondenser_time_cons = float(data.water_condenser.time_constructed)
	wcondenser_time_to_fix = float(data.water_condenser.time_to_fix)
	wcondenser_time_to_man = float(data.water_condenser.time_to_manutence)
	wcondenser_is_constructed = float(data.water_condenser.is_constructed)
	wcondenser_is_in_construction = bool(data.water_condenser.is_in_construction)
	wcondenser_is_broken = bool(data.water_condenser.is_broken)
	wcondenser_water_earnt = bool(data.water_condenser.water_earnt)

func load_syntetizor():
	if GameManager.has_sint:
		var sint_instance = InstantiateConstructionsManager.SINTETYZOR.instantiate()
		main_level.add_child(sint_instance)
		if sint_instance.is_inside_tree():
			sint_instance.position = Vector2(syntetizor_pos.x, syntetizor_pos.y)
			sint_instance.time_constructed = float(syntetizor_is_constructed)
			sint_instance.time_to_fix = float(syntetizor_time_to_fix)
			sint_instance.time_to_go_manutence = float(syntetizor_time_to_man)
			sint_instance.is_constructed = bool(syntetizor_is_constructed)
			sint_instance.is_in_construction = bool(syntetizor_is_in_construction)
			sint_instance.is_broken = bool(syntetizor_is_broken)
			sint_instance.is_instancied = true
			
func load_wcondenser():	
	if GameManager.has_water_cond:
		var wcond_instance = InstantiateConstructionsManager.WATER_CONDENSER.instantiate()
		main_level.add_child(wcond_instance)
		if wcond_instance.is_inside_tree():
			wcond_instance.position = Vector2(wcondenser_pos.x, wcondenser_pos.y)
			wcond_instance.time_constructed = float(wcondenser_is_constructed)
			wcond_instance.time_to_fix = float(wcondenser_time_to_fix)
			wcond_instance.time_to_go_manutence = float(wcondenser_time_to_man)
			wcond_instance.is_constructed = bool(wcondenser_is_constructed)
			wcond_instance.is_in_construction = bool(wcondenser_is_in_construction)
			wcond_instance.is_broken = bool(wcondenser_is_broken)
			wcond_instance.water_earnt = float(wcondenser_water_earnt)
			wcond_instance.is_instancied = true
			
func load_studies_stats(data):
	botanics_studies.actual_level = int(data.botanics_studies.actual_level)
	botanics_studies.actual_experience = float(data.botanics_studies.actual_experience)
	botanics_studies.level_experience_upgrade = float(data.botanics_studies.level_experience_upgrade)
	botanics_studies.current_time_focus = float(data.botanics_studies.current_time_focus)
	
	electronics_studies.actual_level = int(data.electronics_studies.actual_level)
	electronics_studies.actual_experience = float(data.electronics_studies.actual_experience)
	electronics_studies.level_experience_upgrade = float(data.electronics_studies.level_experience_upgrade)
	electronics_studies.current_time_focus = float(data.electronics_studies.current_time_focus)
	
	electronics_studies.actual_level = int(data.electronics_studies.actual_level)
	electronics_studies.actual_experience = float(data.electronics_studies.actual_experience)
	electronics_studies.level_experience_upgrade = float(data.electronics_studies.level_experience_upgrade)
	electronics_studies.current_time_focus = float(data.electronics_studies.current_time_focus)
	
func _showSlot(index):
	var jsonFile = FileAccess.open(slots[index], FileAccess.READ)
	var jsonData = jsonFile.get_as_text()
	jsonFile.close()
	var data = JSON.parse_string(jsonData)
	
	if data == null:
		_clear_labels()
		return
	
	DateLabel.text = str("%d-%02d-%02d" % [data.time_var.t_year, data.time_var.t_month, data.time_var.t_day])
	HourLabel.text = str("%02d:%02d" % [data.time_var.t_hour, data.time_var.t_minutes])
	o2Label.text = str(data.resources.oxygen)
	H2Label.text = str(data.resources.hidrogen)
	EnergyLabel.text = str(data.resources.energy)
	MetalLabel.text = str(data.resources.metal)
	OrganicsLabel.text = str(data.resources.organics)
	GameTypeLabel.text = str(data.gametype.type)
	WaterLabel.text = str(data.resources.water)
	GameDateTimeLabel.text = str("%02d-%02d" % [data.time_var.t_month, data.time_var.t_day])
	GameHourTimeLabel.text = str("%02d:%02d" % [data.time_var.t_hour, data.time_var.t_minutes])
	
func _clear_labels():
	for label in [DateLabel,HourLabel, o2Label, H2Label, EnergyLabel, MetalLabel, OrganicsLabel, WaterLabel, GameDateTimeLabel, GameHourTimeLabel]:
		label.text = "0"
	GameTypeLabel.text = "Não Criado"	
	
func get_construction_data():
	get_fix_robot_data()
	get_hidroponics_data()
	get_miner_robot_data()
	get_solar_panel_stats()
	get_syntetizor_stats()
	get_water_cond_stats()

func get_fix_robot_data():
	var robots = get_tree().get_nodes_in_group("FixRobot")
	if robots:
		for robot in robots:
			fix_robots_pos.append([robot.position.x, robot.position.y])
			fix_robot_time_cons.append(robot.time_constructed)
			fix_robot_time_to_fix.append(robot.time_to_fix)
			fix_robot_time_to_man.append(robot.time_to_go_manutence)
			fix_robot_is_constructed.append(robot.is_constructed)
			fix_robot_is_in_construction.append(robot.is_in_construction)
			fix_robot_is_broken.append(robot.is_broken)
	else:
		return
		
func get_hidroponics_data():
	var hidroponics = get_tree().get_nodes_in_group("Hidroponics")
	if hidroponics:
		for hidro in hidroponics:
			hidroponics_pos.append([hidro.position.x, hidro.position.y])
			hidroponics_time_cons.append(hidro.time_constructed)
			hidroponics_time_to_fix.append(hidro.time_to_fix)
			hidroponics_time_to_man.append(hidro.time_to_go_manutence)
			hidroponics_is_constructed.append(hidro.is_constructed)
			hidroponics_is_in_construction.append(hidro.is_in_construction)
			hidroponics_is_broken.append(hidro.is_broken)
			hidroponics_organics_earnt.append(hidro.organics_earnt)
	else:
		return

func get_miner_robot_data():
	var miners = get_tree().get_nodes_in_group("MinerRobot")
	if miners:
		for miner in miners:
			miner_robot_pos.append([miner.position.x, miner.position.y])
			miner_robot_time_cons.append(miner.time_constructed)
			miner_robot_time_to_fix.append(miner.time_to_fix)
			miner_robot_time_to_man.append(miner.time_to_go_manutence)
			miner_robot_is_constructed.append(miner.is_constructed)
			miner_robot_is_in_construction.append(miner.is_in_construction)
			miner_robot_is_broken.append(miner.is_broken)
			miner_robot_iron_earnt.append(miner.iron_earnt)
	else:
		return

func get_solar_panel_stats():
	var solars = get_tree().get_nodes_in_group("SolarPanel")
	if solars:
		for solar in solars:
			solar_panel_pos.append([solar.position.x, solar.position.y])
			solar_panel_time_cons.append(solar.time_constructed)
			solar_panel_time_to_fix.append(solar.time_to_fix)
			solar_panel_time_to_man.append(solar.time_to_go_manutence)
			solar_panel_is_constructed.append(solar.is_constructed)
			solar_panel_is_in_construction.append(solar.is_in_construction)
			solar_panel_is_broken.append(solar.is_broken)
	else:
		return
		
func get_syntetizor_stats():
	var sint = get_tree().get_first_node_in_group("Syntetizor")
	if sint:
		syntetizor_pos = sint.position
		syntetizor_time_cons = sint.time_constructed
		syntetizor_time_to_fix = sint.time_to_fix
		syntetizor_time_to_man = sint.time_to_manutence
		syntetizor_is_constructed = sint.is_constructed
		syntetizor_is_in_construction = sint.is_in_construction
		syntetizor_is_broken = sint.is_broken
	else:
		return
		
func get_water_cond_stats():
	var wcondenser = get_tree().get_first_node_in_group("WaterCondenser")
	if wcondenser:
		wcondenser_pos = wcondenser.position
		wcondenser_time_cons = wcondenser.time_constructed
		wcondenser_time_to_fix = wcondenser.time_to_fix
		wcondenser_time_to_man = wcondenser.time_to_manutence
		wcondenser_water_earnt = wcondenser.water_earnt
		wcondenser_is_constructed = wcondenser.is_constructed
		wcondenser_is_in_construction = wcondenser.is_in_construction
		wcondenser_is_broken = wcondenser.is_broken
	else:
		return

func destroy_constructions_before_load():
	var constructions = get_tree().get_nodes_in_group("Construction")
	for construction in constructions:
		construction.queue_free()
