extends Control

class_name TutorialMenu

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func fade_in() : 
	
	visible = true
	
	var loading_screen = get_tree().create_tween()
	
	loading_screen.tween_property(self, "modulate:a", 1, 3)
	
	await loading_screen.finished
	
	loading_screen.kill()

func fade_out() : 
	
	var loading_screen = get_tree().create_tween()
	
	loading_screen.tween_property(self, "modulate:a", 0, 1)
	
	await loading_screen.finished
	
	loading_screen.kill()
	
	visible = false
