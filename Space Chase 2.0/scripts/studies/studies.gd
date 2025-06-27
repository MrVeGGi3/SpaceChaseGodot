class_name StudiesUI
extends Control

var actual_level : int = 0
var actual_experience : float
var level_experience_upgrade : float = 1440.0

var progress_focus_bar : ProgressBar
var progress_exp_bar : ProgressBar
var level_label : Label
var actual_level_effects_text : RichTextLabel
var next_level_effects_text : RichTextLabel

var next_level_effects : Control
var actual_level_effects : Control

var studies_boost : int = 2
var time_to_focus_boost : float = 50.0
var current_time_focus : float = 0.0

var exp_multiplier : float = 1.0
var interface_type : String 

var study_button 
var level_button

@export var studies_ui : Control

var metal_increase_value_per_level = [0.0, randf_range(2.0, 4.0), randf_range(5.0, 7.0),
									randf_range(8.0, 10.0), randf_range(11.0, 14.0)]

var organic_increase_value_per_level = [0.0, randf_range(1.0, 2.0), randf_range(3.0, 5.0), 
										randf_range(8.0, 10.0),	randf_range(11.0, 13.0)]
										
var time_cons_decrease_value_per_level = [0.0, 400.00, 800.00, 1000.00, 1200.00]

func _upgrade_level():
	actual_level += 1
	actual_experience = 0.0
	match actual_level:
		"1":
			level_experience_upgrade = 2000.00
		"2":
			level_experience_upgrade = 2100.00
		"3":
			level_experience_upgrade = 2300.00
		"4":
			level_experience_upgrade = 2500.00
		_:
			return

func _set_bonus_metal_gain_per_level():
	GameManager.bonus_metal_increase = metal_increase_value_per_level[actual_level]
			
func _set_bonus_organic_gain_per_level():
	GameManager.bonus_organic_increase = organic_increase_value_per_level[actual_level]
	
func _set_bonus_electronic_gain_per_level():
	GameManager.bonus_electronic_increase = time_cons_decrease_value_per_level[actual_level]

func adjust_exp_bar(delta : float):
	level_label.text = str(actual_level)
	
	progress_exp_bar.max_value = level_experience_upgrade
	progress_exp_bar.value = actual_experience
	
	if visible:
		actual_experience += delta * exp_multiplier
	else:
		return

func set_progress_nodes(p_bar : ProgressBar, e_bar : ProgressBar):
	progress_focus_bar = p_bar 
	progress_exp_bar = e_bar
	
func set_text_nodes(al_effects : RichTextLabel, nl_effects : RichTextLabel, label_l : Label):
	actual_level_effects_text = al_effects
	next_level_effects_text = nl_effects
	level_label = label_l

func set_effects_nodes(nl_effects : Control, al_effects : Control):
	next_level_effects = nl_effects
	actual_level_effects = al_effects
	
func set_initial_status():
	actual_level = 0
	actual_experience = 0.0

func adjust_focus_bar(delta : float):
	progress_focus_bar.value = current_time_focus
	progress_focus_bar.max_value = time_to_focus_boost
	
	if visible:
		current_time_focus += delta 
		
		if current_time_focus >= time_to_focus_boost:
			exp_multiplier = 2.0
			current_time_focus = time_to_focus_boost
	else:
		current_time_focus = 0.0
		exp_multiplier = 1.0
		
func set_buttons(s_button, l_button):
	study_button = s_button
	level_button = l_button
		
func adjust_bars(delta : float):
	adjust_focus_bar(delta)
	adjust_exp_bar(delta)

func see_buttons_hovered():
	if visible and next_level_effects and actual_level_effects:
		if study_button.is_hovered():
			actual_level_effects.show()
		elif level_button.is_hovered():
			next_level_effects.show()
		else:
			hide_effects()
	else:
		return

func hide_effects():
	next_level_effects.hide()
	actual_level_effects.hide()



func get_upgrade_level(type : String, level : int) -> float:
	var amount
	match type:
		"Metal":
			amount = metal_increase_value_per_level[level]
		"Eletronic":
			amount = time_cons_decrease_value_per_level[level]
		"Botanic":
			amount = organic_increase_value_per_level[level]
			
	return amount
func show_upgrades_level():
	var level_upgrade
	var type_upgrade
	var message : String
	match interface_type:
		"Mechnics":
			level_upgrade = get_upgrade_level("Metal", actual_level + 1)
			type_upgrade = "Metal"
			message = "+ {0} kg de {1}".format([level_upgrade, type_upgrade])
		"Electronics":
			level_upgrade = get_upgrade_level("Eletronic", actual_level + 1)
			type_upgrade = "Construção"
			message = " - {0} horas de {1}".format([level_upgrade, type_upgrade])
		"Botanics":
			level_upgrade = get_upgrade_level("Botanic", actual_level + 1)
			type_upgrade = "Orgânicos"
			message = " + {0} kg de {1}".format([level_upgrade, type_upgrade])
	next_level_effects_text.text = message
func show_actual_stats():
	var level_upgrade
	var type_upgrade
	var message
	match interface_type:
		"Mechnics":
			level_upgrade = get_upgrade_level("Metal", actual_level)
			type_upgrade = "Metal"
			message = "+ {0} kg de {1}".format([level_upgrade, type_upgrade])
		"Electronics":
			level_upgrade = get_upgrade_level("Eletronic", actual_level)
			type_upgrade = "Construção"
			message = " - {0} horas de {1}".format(([level_upgrade, type_upgrade]))
		"Botanics":
			level_upgrade = get_upgrade_level("Botanic", actual_level)
			type_upgrade = "Orgânicos"
			message = " + {0} kg de {1}".format(([level_upgrade, type_upgrade]))
	actual_level_effects_text.text = message
func show_upgrades_bars():
	show_actual_stats()
	show_upgrades_level()
