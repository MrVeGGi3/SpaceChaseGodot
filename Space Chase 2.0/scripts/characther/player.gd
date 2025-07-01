class_name Player
extends CharacterBody2D

@export_category("Propriedades")
@export var speed : float = 100.00
@onready var is_moving : bool = false
@onready var target_position : Vector2
@export_category("Status do Player")
@export var oxigen_tank : float = 100.00
@export var thirsty : float = 100.00
@export var hungry : float = 100.00
@export var sleepy : float = 100.00
@export var crazyness : float = 100.00
@export_category("Limite Alcançado")
@export var is_hungry_limit : bool = false
@export var is_thirsty_limit : bool = false
@export var is_crazyness_limit : bool = false
@export var is_sleepy_limit : bool = false
@export var is_oxygen_limit : bool = false

@onready var working_sound: AudioStreamPlayer = $WorkingSound


func _ready():
	target_position = position

func _input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_RIGHT:
			target_position = event.position
			is_moving = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_keep_status_limit()
	if is_moving:
		var direction = (target_position - position).normalized()
		var angle_rad = direction.angle()
		var angle_degress = rad_to_deg(angle_rad)
		var movement = direction * speed * delta
		if position.distance_to(target_position) <= movement.length():
			position = target_position
			is_moving = false
		else: 
			position += movement
	
	for value in [oxigen_tank, hungry, thirsty, crazyness, sleepy]:
		if value < 0.0:
			value = 0.0
	
	if oxigen_tank <= 0.0:
		is_oxygen_limit = true
	if thirsty <= 0.0:
		is_crazyness_limit = true
	if hungry <= 0.0:
		is_hungry_limit = true
	if thirsty <=0.0:
		is_thirsty_limit = true
	if sleepy <= 0.0:
		is_sleepy_limit = true

func _set_hungry_limit(state : bool):
	is_hungry_limit = state
func _set_thirsty_limit(state : bool):
	is_thirsty_limit = state
func _set_crazyness_limit(state : bool):
	is_crazyness_limit = state
func _set_sleepy_limit(state : bool):
	is_sleepy_limit = state
func _set_oxigen_limit(state : bool):
	is_oxygen_limit = state

func _get_hungry_limit():
	return is_hungry_limit
func _get_thirsty_limit():
	return is_thirsty_limit
func _get_crazyness_limit():
	return is_crazyness_limit
func _get_sleepy_limit():
	return is_sleepy_limit
func _get_oxigen_limit():
	return is_oxygen_limit


func _keep_status_limit():
	for value in [thirsty, hungry, crazyness, sleepy, oxigen_tank]:
		if value >= 100:
			value = 100

func play_working_sound():
	working_sound.play()

func stop_working_sound():
	working_sound.stop()
	
func _on_working_sound_finished() -> void:
	working_sound.play()
