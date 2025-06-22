class_name Sintetizor
extends Construction

@onready var hidrogen_input: LineEdit = $HidroToEnergy/HidrogenInput
@onready var water_input: LineEdit = $WaterToHidroAndOxi/WaterInput
@onready var hidrogen_input_2: LineEdit = $HidroOxiToWater/HidrogenInput2
@onready var oxygen_input: LineEdit = $HidroOxiToWater/OxygenInput

@onready var energy_auto_fill: LineEdit = $WaterToHidroAndOxi/EnergyAutoFill
@onready var energy_output: LineEdit = $HidroToEnergy/EnergyOutput
@onready var hidrogen_output: LineEdit = $WaterToHidroAndOxi/HidrogenOutput
@onready var oxygen_output: LineEdit = $WaterToHidroAndOxi/OxygenOutput
@onready var water_output: LineEdit = $HidroOxiToWater/WaterOutput

const  hidro_to_oxy_proportion = 0.5
const hidro_to_energy_rate = 64.75
const water_to_energy_rate = 41.6

@onready var energy_conversion : float
@onready var oxigen_conversion : float
@onready var hidrogen_conversion : float
@onready var energy_spending : float

@onready var hidrogen_value : float
@onready var hidrogen_value_2 : float
@onready var oxygen_value : float
@onready var water_value : float
@onready var water_value_2 : float

@onready var confirm_erase_window: Window = $ConfirmEraseWindow
@onready var subtract_materials = [hidrogen_value, hidrogen_value_2, oxygen_value, water_value]
@onready var add_materials = [energy_conversion, oxigen_conversion, water_value_2, hidrogen_conversion]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	check_can_sint_ui_status()
	
	energy_output.text = str(energy_conversion)
	energy_auto_fill.text = str(energy_spending)
	hidrogen_output.text = str(hidrogen_conversion)
	oxygen_output.text = str(oxigen_conversion)
	water_output.text = str(water_value_2)
	oxygen_input.text  = str(oxygen_value)

func _on_hidrogen_input_text_changed(new_text: String) -> void:
	hidrogen_value = float(new_text)
	energy_conversion = hidrogen_value * hidro_to_energy_rate


func _on_water_input_text_changed(new_text: String) -> void:
	water_value = float(new_text)
	energy_spending = water_value * water_to_energy_rate
	hidrogen_conversion = water_value
	oxigen_conversion = water_value/2
	

func _on_hidrogen_input_2_text_changed(new_text: String) -> void:
	hidrogen_value_2 = float(new_text)
	oxygen_value = hidrogen_value_2 * hidro_to_oxy_proportion
	water_value_2 = hidrogen_value_2
	

func _on_oxygen_input_text_changed(new_text: String) -> void:
	oxygen_value = float(new_text)
	hidrogen_input_2.text = str(oxygen_value/hidro_to_oxy_proportion)
	hidrogen_value_2 = oxygen_value / hidro_to_oxy_proportion
	water_value_2 = oxygen_value / 2


func _on_confirm_pressed() -> void:
	convert_materials()
	
func _on_apagar_pressed() -> void:
	confirm_erase_window.show()

func _on_voltar_pressed() -> void:
	hide()

func _on_yes_pressed() -> void:
	reset_values()

func _on_no_pressed() -> void:
	GameManager.can_activate_sint_ui = false

func convert_materials():
	GameManager.energy += energy_conversion - energy_spending
	GameManager.hidrogen += hidrogen_value + hidrogen_value_2 - hidrogen_conversion
	GameManager.oxigen += oxigen_conversion - oxygen_value
	GameManager.water += water_value_2 - water_value
	reset_values()

func reset_values(): 
	for item in subtract_materials:
		item = 0.0
	for item in add_materials:
		item = 0.0

func check_can_sint_ui_status():
	if GameManager.can_activate_sint_ui == true:
		show()
	else:
		hide()
