extends Control

@export var mem_tile_scene: PackedScene

@onready var exit_sound = $ExitSound
@onready var tile_container = $HB/MC1/TileContainer
@onready var scorer: Scorer = $Scorer
@onready var moves_label = $HB/MC2/VB/HB/MovesLabel
@onready var pairs_label = $HB/MC2/VB/HB2/PairsLabel

func _ready():
	SignalManager.on_level_selected.connect(on_level_selected)
	
func _process(_delta):
	moves_label.text = scorer.get_moves_made_str()	
	pairs_label.text = scorer.get_pairs_made_str()	
	
func add_memory_tile(
	ii_dict: Dictionary,
	frame_img: CompressedTexture2D
) -> void:
	var new_tile = mem_tile_scene.instantiate()
	tile_container.add_child(new_tile)
	new_tile.setup(ii_dict, frame_img)
	
func on_level_selected(level_num: int) -> void:
	var level_selection = GameManager.get_level_selection(level_num)
	var frame_image = ImageManager.get_random_frame_image()
	
	tile_container.columns = level_selection.num_cols
	
	for ii_dict in level_selection.image_list:
		add_memory_tile(ii_dict, frame_image)
		
	scorer.clear_new_game(level_selection.target_pairs)
		
func _on_exit_button_pressed() -> void:
	SoundManager.play_button_click(exit_sound)
	SignalManager.on_game_exit_pressed.emit()
