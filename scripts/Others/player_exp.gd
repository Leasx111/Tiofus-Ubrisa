extends TextureProgressBar


signal max_xp_reached

func _on_value_changed(xp_value: float) -> void:
	
	if xp_value >= self.max_value and get_tree().get_processed_tweens() :
		
		emit_signal("max_xp_reached")
