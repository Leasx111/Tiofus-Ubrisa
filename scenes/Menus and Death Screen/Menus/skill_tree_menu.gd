extends Control

@export var node_2d: Node2D

var dragging : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void :
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void :
	pass


func _input(event) -> void :
	
	if event is InputEventMouseButton:
		
		if event.is_pressed():
			
			dragging = true
		
		else:
			
			dragging = false
	
	elif event is InputEventMouseMotion and dragging :
		
		node_2d.position += (event.relative) / 4
