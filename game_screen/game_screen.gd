extends Control


func _ready():
	pass
	
func _on_exit_button_pressed() -> void:
	SignalManager.on_game_exit_pressed.emit()
