class_name Construction
extends Node2D


@onready var player = get_tree().get_first_node_in_group("Player")


var metal_price : float
var time_to_construct : float
var fixing_time : float
var manutence_time : float

var time_constructed : float
var time_to_go_manutence : float
var time_to_fix : float

var time_to_generate_material : float

var is_in_construction : bool
var is_constructed : bool
var is_being_fixed : bool
var is_broken : bool

var button_mode = ["Construct", "Fix"]
var actual_button_mode 
var construction_area_2d
var construction_progress_bar
var construction_fix_button
var material_collect_button

func check_time_to_construct():
	if time_constructed >= time_to_construct:
		is_constructed = true
		is_in_construction = false

func check_time_to_manutence():
	if time_to_go_manutence >= manutence_time:
		is_broken = true
		time_to_go_manutence = 0.0

func check_time_to_fix():
	if time_to_fix >= fixing_time:
		is_broken = false
		is_being_fixed = false
		time_to_fix = 0.0

func reset_manutence_variables():
	time_to_go_manutence = 0.0
	time_to_fix = 0.0

func _start_construction():
	GameManager.metal -= metal_price

func get_is_constructed() -> bool:
	return is_constructed

func set_initial_status(time : float, price : float, m_time : float, f_time : float):
	is_in_construction = false
	time_to_construct = time
	metal_price = price
	manutence_time = m_time
	fixing_time = f_time

func hide_construction_UI():
	construction_fix_button.hide()
	construction_progress_bar.hide()
	if material_collect_button:
		material_collect_button.hide()

func set_initial_nodes(button, p_bar, area):
	construction_fix_button = button
	construction_progress_bar = p_bar
	construction_area_2d = area

func set_button_mode():
	if not is_constructed:
		actual_button_mode = button_mode[0]
	elif is_broken:
		actual_button_mode = button_mode[1]
		
	match actual_button_mode:
		"Construct":
			construction_fix_button.text = str("Construct")
		"Fix":
			construction_fix_button.text = str("Fix")

func player_exited_area():
	construction_fix_button.hide()
	if not is_constructed:
		is_in_construction = false
	elif is_broken:
		is_being_fixed = false
	construction_progress_bar.hide()
	player.stop_working_sound()

func player_entered_area():
	if not is_constructed or is_broken:
		construction_fix_button.show()
	
func construction_button_pressed():
	if not is_constructed:
		is_in_construction = true
	elif is_broken:
		is_being_fixed = true
	player.play_working_sound()
	construction_progress_bar.show()


func see_bodies_around():
	return construction_area_2d.get_overlapping_bodies()
	
func see_areas_around():
	return construction_area_2d.get_overlapping_areas()
	
func decrease_time_with_bonus():
	time_to_construct -= GameManager.bonus_electronic_increase
