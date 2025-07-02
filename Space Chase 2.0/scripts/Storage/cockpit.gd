extends Node2D

@onready var radar_conditions_list: Node2D = $"../RadarConditionsList"
@onready var cockpit_animation_player: AnimationPlayer = $CockpitAnimationPlayer
@onready var inside_space_shuttle: Node2D = $"../InsideSpaceShuttle"
@onready var cant_travel: Label = $ColorRect/CantTravel
@onready var go_to_shuttle: Button = $GoToShuttle

@onready var radar_opened: AudioStreamPlayer = $AudioManager/RadarOpened


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	cant_travel.text = tr("NO_ITENS_TO FLIGHT")
	go_to_shuttle.text = tr("BACK_HIDE")


func _on_cockpit_pressed() -> void:
	radar_opened.play()
	radar_conditions_list.show()


func _on_to_take_over_pressed() -> void:
	if GameManager.get_win_game_status():
		GameEnd()
	else:
		cockpit_animation_player.play("can't travel")


func _on_go_to_shuttle_pressed() -> void:
	visible = false
	inside_space_shuttle.show()

func GameEnd():
	print("O jogo acabou")
