extends Control

var curiosities = []
var curiosities_index 

@onready var curiositiesLabel: Label = $CuriositiesLabel
@onready var change_curiosity_timer: Timer = $ChangeCuriosity
@onready var change_scene_timer : Timer = $ChangeScene
@onready var loading_label: Label = $LoadingLabel

const MainLevel = "res://scenes/level/MainLevel.tscn"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	curiosities.append("A Purificação da Água são feitas de duas formas: Prata e Iodo")
	curiosities.append("Um Ano em Marte equivale a 687 dias terrestres")
	curiosities.append("Os Astronautas dormem em pé no espaço")
	curiosities.append("Marte emite muita radiação solar, por isso é necessário equipamento adequado")
	curiosities.append("A Gravidade de Marte é 62% menor que a gravidade da terra")
	curiosities.append("São necessários 6 á 9 meses de viagem até Marte")
	curiosities.append("O Pai da Astronáutica Moderna: Konstantin Tsiolkovsky")
	curiosities.append("O primeiro animal á ser lançado no espaço: Cadela Laika em 1957")
	curiosities.append("O primeiro homem á pisar na Lua: Yuri Gargarin em 1961")
	curiosities.append("RASSOR é o nome do Robô de Mineração e Extração da NASA")
	_show_curiosity()
	change_scene_timer.start()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	curiositiesLabel.text = str(curiosities[curiosities_index])
		

func _show_curiosity():
	curiosities_index = randi_range(0, curiosities.size() - 1)
	change_curiosity_timer.start()

func _on_change_curiosity_timeout() -> void:
	_show_curiosity()

func _on_change_scene_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/level/MainLevel.tscn")
