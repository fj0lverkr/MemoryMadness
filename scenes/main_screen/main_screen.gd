extends Control

@export var level_button_scene: PackedScene
@onready var hb_levels: HBoxContainer = $"VBoxContainer/HBLevels"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_set_up_grid()

func _set_up_grid() -> void:
	for level: int in GameManager.LEVELS:
		var level_button_instance: Node = level_button_scene.instantiate()
		hb_levels.add_child(level_button_instance)
		level_button_instance.set_level_number(level)
