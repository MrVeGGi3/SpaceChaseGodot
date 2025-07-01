extends Control
@onready var bgm_bar: HScrollBar = $SoundContainer/BGMContainer/BGMBar
@onready var sfx_bar: HScrollBar = $SoundContainer/SFXContainer/SFXBar
@onready var audio_label: Label = $SoundContainer/AudioLabel
@onready var sfx_label: Label = $SoundContainer/SFXContainer/SFXLabel
@onready var bgm_label: Label = $SoundContainer/BGMContainer/BGMLabel 

var sfx_index
var bgm_index


func _process(delta: float) -> void:
	audio_label.text = tr("AUDIO_ADJUST_TITLE")
	sfx_label.text = tr("SFX_NAME")
	bgm_label.text = tr("BGM_NAME")


func _ready() -> void:
	get_and_set_audiobus_value()
	


func get_and_set_audiobus_value():
	bgm_index = AudioServer.get_bus_index("BGM")
	sfx_index = AudioServer.get_bus_index("SFX")
	bgm_bar.value = db_to_linear(AudioServer.get_bus_volume_db(bgm_index))
	sfx_bar.value = db_to_linear(AudioServer.get_bus_volume_db(sfx_index))

func _on_bgm_bar_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(bgm_index, linear_to_db(value))

func _on_sfx_bar_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(sfx_index, linear_to_db(value))
