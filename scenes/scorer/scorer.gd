extends Node

class_name Scorer

@onready var sound: AudioStreamPlayer = $Sound
@onready var reveal_timer: Timer = $RevealTimer

var _selected_tiles: Array[MemoryTile] = []
var _target_pairs: int = 0
var _moves: int = 0
var _pairs_made: int = 0

func _ready() -> void:
	SignalBus.on_tile_selected.connect(_on_tile_selected)
	SignalBus.on_game_exit_pressed.connect(_on_game_exit_pressed)

func _update_selections() -> void:
	reveal_timer.start()
	if _selections_are_pairs():
		_remove_tiles()

func _hide_selections() -> void:
	for s: MemoryTile in _selected_tiles:
		s.toggle_reveal(false)

func _do_game_over() -> void:
	AudioManager.play_sound(sound, AudioManager.SOUND_GAME_OVER)
	SignalBus.on_game_over.emit(_moves)

func _remove_tiles() -> void:
	for t in _selected_tiles:
		t.remove_on_success()
	_pairs_made += 1
	SignalBus.on_pair_made.emit(_pairs_made)
	AudioManager.play_sound(sound, AudioManager.SOUND_SUCCESS)

func _selections_are_pairs() -> bool:
	return (
		_selected_tiles[0].get_item_name() == _selected_tiles[1].get_item_name()
		and
		_selected_tiles[0].get_instance_id() != _selected_tiles[1].get_instance_id()
	)

func _check_pair_made(tile: MemoryTile) -> void:
	tile.toggle_reveal(true)
	_selected_tiles.append(tile)
	if _selected_tiles.size() != 2:
		return

	SignalBus.on_select_disabled.emit()
	_moves += 1
	SignalBus.on_move_made.emit(_moves)
	_update_selections()

func _on_tile_selected(tile: MemoryTile) -> void:
	AudioManager.play_tile_clicked(sound)
	_check_pair_made(tile)

func clear_game(target_pairs: int) -> void:
	_target_pairs = target_pairs
	_selected_tiles.clear()
	_moves = 0
	_pairs_made = 0

func _on_reveal_timer_timeout() -> void:
	if !_selections_are_pairs():
		_hide_selections()
		
	_selected_tiles.clear()
	SignalBus.on_select_enabled.emit()
	
	if _pairs_made == _target_pairs:
		_do_game_over()

func _on_game_exit_pressed() -> void:
	reveal_timer.stop()