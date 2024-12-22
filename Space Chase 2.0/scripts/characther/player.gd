class_name Player
extends CharacterBody2D

@export_category("Propriedades")
@export var speed : float = 100.00
@onready var is_moving : bool = false
@onready var target_position : Vector2
@export_category("Status do Player")
@onready var oxigen_player : int = 100
@onready var thirsty : int = 100
@onready var hungry : int = 100
@onready var sleepy : int = 100
@onready var crazyness : int = 100
@export_category("Limite Alcançado")
@export var is_hungry_limit : bool = false
@export var is_thirsty_limit : bool = false
@export var is_crazyness_limit : bool = false
@export var is_sleepy_limit : bool = false
@export var is_oxygen_limit : bool = false

func _ready():
	target_position = position

func _input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			target_position = event.position
			
			is_moving = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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
	
	for value in [oxigen_player, hungry, thirsty, crazyness, sleepy]:
		if value < 0:
			value = 0
	
	if oxigen_player <= 0:
		is_oxygen_limit = true
	if thirsty <= 0 :
		is_crazyness_limit = true
	if hungry <= 0:
		is_hungry_limit = true
	if thirsty <=0:
		is_thirsty_limit = true
	if sleepy <= 0:
		is_sleepy_limit = true

func _set_hungry_limit(state : bool):
	is_hungry_limit = state
func _set_thirsty_limit(state : bool):
	is_thirsty_limit = state
func _set_crazyness_limit(state : bool):
	is_crazyness_limit = state
func _set_sleepy_limit(state : bool):
	is_sleepy_limit = state
func _set_oxygen_limit(state : bool):
	is_oxygen_limit = state

func _get_hungry_limit():
	return is_hungry_limit
func _get_thirsty_limit():
	return is_thirsty_limit
func _get_crazyness_limit():
	return is_crazyness_limit
func _get_sleepy_limit():
	return is_sleepy_limit
func _get_oxygen_limit():
	return is_oxygen_limit
	

	
#Oito tipos de movimento possiveis.
#Frente, Trás, Esquerda, Direita, 
#Diagonal Esquerda Inferior, Diagonal Direita Inferior, Diagonal Esquerda Superior, Diagonal Direita Inferior
#if angle_degress <= -110 and angle_degrees <= -70:
#      animation_player.play("atrás")
#if angle_degress <= 69 and angle_degrees <= -20:
#      animation_player.play("diagonal superior direita")
#if angle_degress <= -155 and angle_degrees <= -115:
#		animation_player.play("diagonal superior direita")
#if angle_degress >= 160  and angle_degrees <= -160: 
#		animation_player.play("esquerda")
#if angle_degrees <= 155 and angle_degrees >= 115: 
#		animation_player.play("diagonal inferior esquerda")
#if angle_degrees <= 110 and angle_degrees >= 70:
#		animation_player.play("frente")
#if angle_degrees <= 65 and angle_degrees >= 25:
#		animation_player.play("diagonal inferior direita")
#if angle_degrees >= -20 and angle_degrees <= 20:
#		animation_player.play("direita") 
