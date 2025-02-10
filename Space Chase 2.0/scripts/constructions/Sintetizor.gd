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



var hidro_to_oxy_proportion = 0.5
var hidro_to_energy_rate = 64.75
var water_to_energy_rate = 41.6

var energy_conversion : float
var oxigen_conversion : float
var hidrogen_conversion : float
var energy_spending : float

var hidrogen_value : float
var hidrogen_value_2 : float
var oxygen_value : float
var water_value : float
var water_value_2 : float
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
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
	hidrogen_value_2 = oxygen_value / hidro_to_oxy_proportion
	water_value_2 = oxygen_value / 2
