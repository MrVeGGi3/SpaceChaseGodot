extends Node

@export var status_ui : Control
@export var main_level : Node2D
@export var constructions: Control

func _ready() -> void:
	InstantiateConstructionsManager.set_main_nodes_path(status_ui, main_level, constructions)
