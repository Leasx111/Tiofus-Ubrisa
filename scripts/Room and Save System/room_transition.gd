extends ColorRect

class_name RoomTransition

signal tween_finished

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void :
	
	pass

func fade_in() -> void : 
	
	visible = true
	
	var loading_screen : Tween = get_tree().create_tween()
	
	loading_screen.tween_property(self, "modulate:a", 1, 1)
	
	await loading_screen.finished
	
	loading_screen.kill()

func fade_out() -> void : 
	
	var loading_screen : Tween = get_tree().create_tween()
	
	loading_screen.tween_property(self, "modulate:a", 0, 1)
	
	await loading_screen.finished
	
	loading_screen.kill()
	
	visible = false
	
	emit_signal("tween_finished")
