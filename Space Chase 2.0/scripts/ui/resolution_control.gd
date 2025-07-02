extends Control
@onready var screen_resolution: Label = $ScreenResolution



func _process(delta: float) -> void:
	screen_resolution.text = tr("SCREEN_MODE")

func _on_fullscreen_pressed() -> void:
	print("Estou pressionando a tecla de Fullscreen")
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func _on_windowed_pressed() -> void:
	print("Estou pressionando a tecla de Windowed")
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_borderless_pressed() -> void:
	print("Estou pressionando a tecla de sem borda")
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)

func _on_with_border_pressed() -> void:
	print("Estou pressionando a tecla de com borda")
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
