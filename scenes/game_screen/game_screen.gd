extends Control

@onready var audio: AudioStreamPlayer = $Sound

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.on_level_selected.connect(_on_level_selected)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_exit_button_pressed() -> void:
	AudioManager.play_button_clicked(audio)
	SignalBus.on_game_exit_pressed.emit()

func _on_level_selected(level: int) -> void:
	var level_selection: Dictionary = GameManager.get_level_selection(level)
	var frame: CompressedTexture2D = ImageManager.get_random_frame()
