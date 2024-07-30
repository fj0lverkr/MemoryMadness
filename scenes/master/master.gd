extends CanvasLayer

@onready var main_screen: Control = $"MainScreen"
@onready var game_screen: Control = $"GameScreen"
@onready var audio: AudioStreamPlayer = $Sound

func _ready() -> void:
	_on_game_exit_pressed()
	SignalBus.on_game_exit_pressed.connect(_on_game_exit_pressed)
	SignalBus.on_level_selected.connect(_on_level_selected)

func _show_game_screen(show_screen: bool) -> void:
	game_screen.visible = show_screen
	main_screen.visible = !show_screen

func _on_game_exit_pressed() -> void:
	_show_game_screen(false)
	AudioManager.play_sound(audio, AudioManager.SOUND_MAIN_MENU)

func _on_level_selected(_level: int) -> void:
	_show_game_screen(true)
	AudioManager.play_sound(audio, AudioManager.SOUND_IN_GAME)
