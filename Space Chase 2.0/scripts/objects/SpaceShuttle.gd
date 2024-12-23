extends Node2D

@onready var rocket_area = $Sprite2D/Area2D
@onready var can_interact_ui: Control = $CanInteractUI
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var bodies = rocket_area.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("player"):
			pass


func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	if body.is_in_group("player"):
		can_interact_ui.show()

func _on_area_2d_body_exited(body: CharacterBody2D) -> void:
	if body.is_in_group("player"):
		can_interact_ui.hide()
