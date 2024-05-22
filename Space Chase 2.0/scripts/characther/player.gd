class_name Player
extends CharacterBody2D

#variavéis de localização e movimento
@export var speed : float = 100.00
@onready var is_moving : bool = false
@onready var target_position : Vector2
#variáveis de controle de status do player
@onready var oxigen_player : int = 100
@onready var thirsty : int = 0
@onready var hungry : int = 0
@onready var sleepy : int = 0
@onready var crazyness : int = 0
#variável se o player está dentro ou fora:
@onready var is_outside = GameManager.is_player_outside

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
		print(angle_degress)
		var movement = direction * speed * delta
		if position.distance_to(target_position) <= movement.length():
			position = target_position
			is_moving = false
		else: 
			position += movement
	if is_outside:
		oxigen_player -= 2 * delta 
	hungry -= 1 * delta
	thirsty -= 2 * delta
	sleepy += 1 * delta
	crazyness += 0.5 * delta
	
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
