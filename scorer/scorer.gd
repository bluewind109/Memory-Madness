extends Node

@onready var sound = $Sound
@onready var reveal_timer = $RevealTimer

var _selections: Array = []
var _target_pairs: int = 0
var _moves_made: int = 0
var _pairs_made: int = 0

func _ready():
	SignalManager.on_tile_selected.connect(on_tile_selected)
	SignalManager.on_game_exit_pressed.connect(on_game_exit_pressed)

func _process(_delta):
	pass

func clear_new_game(target_pairs: int) -> void:
	_selections.clear()
	_pairs_made = 0
	_moves_made = 0
	_target_pairs = target_pairs
	
func selections_are_pair() -> bool:
	return (
		_selections[0].get_instance_id() != _selections[1].get_instance_id()
		and
		_selections[0].get_item_name() == _selections[1].get_item_name()
	)

func kill_tiles() -> void:
	for selection in _selections:
		selection.kill_on_success()
	
	_pairs_made += 1
	SoundManager.play_sound(sound, SoundManager.SOUND_SUCCESS)

func update_selections() -> void:
	reveal_timer.start()
	if (selections_are_pair() == true):
		kill_tiles()

func check_pair_made(tile: MemoryTile) -> void:
	tile.reveal(true)
	_selections.append(tile)
	
	if (_selections.size() != 2):
		return
	
	SignalManager.on_selection_disabled.emit()
	_moves_made += 1
	
	update_selections()

func hide_selections() -> void:
	for selection in _selections:
		selection.reveal(false)

func on_tile_selected(tile: MemoryTile) -> void:
	if (tile.get_can_select() == false): return
	
	tile.set_can_select(false)
	SoundManager.play_tile_click(sound)
	check_pair_made(tile)

func _on_reveal_timer_timeout() -> void:
	reveal_timer.stop()
	if (
		_selections.size() == 2 
		and 
		selections_are_pair() == false
	):
		hide_selections()
	_selections.clear()
	SignalManager.on_selection_enabled.emit()

func on_game_exit_pressed() -> void:
	reveal_timer.stop()
