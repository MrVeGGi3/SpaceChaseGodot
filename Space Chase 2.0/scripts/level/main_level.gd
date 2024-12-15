extends Node2D
@onready var save_load_screen: Node2D = $SaveLoadScreen
@onready var slot_index = GameManager.slot_index

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Engine.time_scale = 1.0
	if save_load_screen.get_acess_type():
		save_load_screen.manager_nodes[slot_index]._save(slot_index)
	elif !save_load_screen.get_acess_type():
		save_load_screen.manager_nodes[slot_index]._load(slot_index)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
