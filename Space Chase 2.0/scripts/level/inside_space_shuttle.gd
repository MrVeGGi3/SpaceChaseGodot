extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var player = get_tree().get_first_node_in_group("player")
@onready var main_level: Node2D = $".."
@onready var space_shuttle: Node2D = $"../SpaceShuttle"
@onready var cockpit: Node2D = $"../Cockpit"
@onready var sleep_button: Button = $SleepButton



@export_category("Action in Buttons")
@export var add_time_when_sleeping : float
@export var subtract_organics_when_eating : float
@export var subtract_water_when_drinking : float

@export_category("Increase Player Status") 
@export var sleepy_increase_status : float
@export var hungry_increase_status : float
@export var crazyness_increase_status : float
@export var thirsty_increase_status : float


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _on_drink_button_pressed() -> void:
	_add_thirsty_status()


func _on_sleep_button_pressed() -> void:
	_add_sleepy_status(player.sleepy)


func _on_fun_button_pressed() -> void:
	_add_crazyness_status()


func _on_go_cabin_button_pressed() -> void:
	visible = false
	cockpit.show()


func _on_go_out_button_pressed() -> void:
	visible = false
	player.show()
	GameManager.is_player_outside = true
	space_shuttle.show()


func _add_sleepy_status(sleepy : float):
	add_time_when_sleeping = (100 - sleepy) * 16.00
	animation_player.play("sleep")
	GameManager.energy -= add_time_when_sleeping * main_level._get_loss_energy_per_minute()
	GameManager.minutes += add_time_when_sleeping
	player.sleepy = 100.00
	player.hungry -= add_time_when_sleeping* main_level._get_hungry_loss_per_minute()
	player.thirsty -= add_time_when_sleeping * main_level._get_thirsty_loss_per_minute()
	player.crazyness += add_time_when_sleeping * main_level._get_crazyness_loss_per_minute()
		

func _add_thirsty_status():
	if player.thirsty < 100:
		player.thirsty += thirsty_increase_status
		GameManager.water -= subtract_water_when_drinking

func _add_hungry_status():
	if player.hungry < 100:
		player.hungry += hungry_increase_status
		GameManager.organics -= subtract_organics_when_eating
	

func _set_add_status_per_action(thirsty_increase : float, hungry_increase : float, crazyness_increase : float):
	thirsty_increase_status = thirsty_increase
	hungry_increase_status = hungry_increase
	crazyness_increase_status = crazyness_increase
	
func _on_eat_button_pressed() -> void:
	_add_hungry_status()

func _add_crazyness_status():
	if player.crazyness < 100:
		player.crazyness += crazyness_increase_status

func _show_player_and_shuttle():
	player.show()
	space_shuttle.show()
