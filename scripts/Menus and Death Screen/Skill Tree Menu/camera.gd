extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _input(event: InputEvent) -> void : 
	
	if event.is_action_released("zoom_in") and self.zoom < Vector2(3.9, 3.9) :
		
		_set_zoom(Vector2(0.1,0.1))
	
	if event.is_action_released("zoom_out") and self.zoom > Vector2(1.0, 1.0) :
		
		_set_zoom(Vector2(-0.1, -0.1))

func _set_zoom(delta: Vector2) -> void :
	
	var mouse_pos : Vector2 = get_global_mouse_position()
	
	zoom += delta
	
	var new_mouse_pos : Vector2 = get_global_mouse_position()
	
	position += mouse_pos - new_mouse_pos
