extends Control

@onready var moves_taken_label = $NinePatchRect/MC/VB/HB/MovesTakenLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_exit_button_pressed():
	hide()
	SignalManager.on_game_exit_pressed.emit()
