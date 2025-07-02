extends Control

@onready var close_radar: Button = $"../CloseRadar"
@onready var fuel_drive_label: Label = $"../ItensToBuild/ItensContainer/FuelDriveLabel"
@onready var fix_robots_label: Label = $"../ItensToBuild/ItensContainer/FixRobotsLabel"


func _process(delta: float) -> void:
	close_radar.text = tr("BACK_HIDE")
	fuel_drive_label.text = tr("FUEL")
	fix_robots_label.text = tr("FIX_ROBOTS_NECESSARY")
