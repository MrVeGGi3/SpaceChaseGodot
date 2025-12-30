extends Control
@onready var constructions_label: Label = $"../ToolsControl/ConstructionsLabel"
@onready var studies_label: Label = $"../ToolsControl/StudiesLabel"

func _process(delta: float) -> void:
	constructions_label.text = tr("BUILD_BUTTON")
	studies_label.text = tr("STUDIES_TITLE")
