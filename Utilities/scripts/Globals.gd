extends Node

signal shake_requested(amount: float)

func shake(amount: float = 4.0) -> void:
	shake_requested.emit(amount)
