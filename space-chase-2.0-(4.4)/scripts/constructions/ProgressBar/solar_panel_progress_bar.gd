class_name SolarPanelProgressBar
extends ConstructionProgressBar

func _ready() -> void:
	set_node_local($"..",$"../SolarPanelAnimSprite2D", $"../ChangeColorProgressBar")
	
func _process(delta: float) -> void:
	switch_progress_bar_value()
