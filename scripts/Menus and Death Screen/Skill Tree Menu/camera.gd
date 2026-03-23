extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _input(event: InputEvent) -> void : 
	
	if event.is_action_released("zoom_in") and self.zoom < Vector2(3.9, 3.9) :
		
		var mouse_pos = get_viewport().get_mouse_position()
		
		self.zoom += Vector2(0.1, 0.1)
		
		self.offset += (mouse_pos - self.position) / 100 
	
	if event.is_action_released("zoom_out") and self.zoom > Vector2(1.0, 1.0) :
		
		var mouse_pos = get_viewport().get_mouse_position()
		
		self.zoom -= Vector2(0.1, 0.1)
		
		self.offset -= (mouse_pos - self.position) / 100
