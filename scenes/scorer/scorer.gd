extends Node

class_name Scorer

@onready var sound: AudioStreamPlayer = $Sound
@onready var reveal_timer: Timer = $RevealTimer

var _tiles: Array[Node] = []
var _selected_tiles: Array[MemoryTile] = []
var _target_pairs: int = 0
var _moves: int = 0
var _pairs_made: int = 0

func _ready() -> void:
	SignalBus.on_tile_selected.connect(_on_tile_selected)
	SignalBus.on_game_exit_pressed.connect(_on_game_exit_pressed)

func _update_selections() -> void:
	reveal_timer.start()

func _hide_selections() -> void:
	for s: MemoryTile in _selected_tiles:
		s.toggle_reveal(false)
	_selected_tiles.clear()
	SignalBus.on_select_enabled.emit()

func _check_pair_made(tile: MemoryTile) -> void:
	tile.toggle_reveal(true)
	_selected_tiles.append(tile)
	if _selected_tiles.size() != 2:
		return

	SignalBus.on_select_disabled.emit()
	_moves += 1
	_update_selections()

func _on_tile_selected(tile: MemoryTile) -> void:
	AudioManager.play_tile_clicked(sound)
	_check_pair_made(tile)

func clear_game(target_pairs: int) -> void:
	_target_pairs = target_pairs
	_selected_tiles.clear()
	_moves = 0
	_pairs_made = 0
	_tiles = get_tree().get_nodes_in_group(GameManager.TILES_GROUP)

func _on_game_exit_pressed() -> void:
	reveal_timer.stop()