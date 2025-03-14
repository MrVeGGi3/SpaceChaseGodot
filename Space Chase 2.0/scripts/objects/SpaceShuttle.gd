extends Node2D

@onready var rocket_area = $Sprite2D/Area2D
@onready var can_interact_ui: Control = $CanInteractUI
@onready var status_control: Control = $"../StatusControl"
@onready var inside_space_shuttle: Node2D = $"../InsideSpaceShuttle"
@onready var player = get_tree().get_first_node_in_group("player")

var can_action = false
# Called when the node enters the scene tree for the first time.
func _ready():
	can_interact_ui.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if can_action and Input.is_action_just_pressed("ação"):
		print("Botão para acionar o StatusControl acionado")
		inside_space_shuttle.show()
		_hide_player_and_shuttle()
		GameManager.is_player_outside = false
		
func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	if body.is_in_group("player"):
		can_interact_ui.show()
		can_action = true

func _on_area_2d_body_exited(body: CharacterBody2D) -> void:
	if body.is_in_group("player"):
		can_interact_ui.hide()
		can_action = false

func _hide_player_and_shuttle():
	hide()
	player.hide()
