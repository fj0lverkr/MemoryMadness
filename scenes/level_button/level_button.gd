extends TextureButton

@onready var level_label: Label = $LevelLabel
@onready var button_audio_player: AudioStreamPlayer = $Sound

var _level_number: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func set_level_number(level_num: int) -> void:
	_level_number = level_num
	var level_data: Dictionary = GameManager.LEVELS[_level_number]
	level_label.text = "%sx%s" % [level_data.rows, level_data.cols]


func _on_pressed() -> void:
	AudioManager.play_button_clicked(button_audio_player)
