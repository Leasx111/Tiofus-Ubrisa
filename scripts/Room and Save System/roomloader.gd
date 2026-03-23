extends Node

class_name RoomLoader

@export var room_holder : Node
@export var colorrect : ColorRect
@export var player : Player

@onready var current_room : Node

# Called when the node enters the scene tree for the first time.
func change_room(new_room, spawn_point) -> void :
	
	if current_room :
		
		await colorrect.fade_in()
	
	var room = new_room.instantiate()
	
	if current_room :
		
		room_holder.remove_child(current_room)
		current_room.queue_free()
	
	room_holder.add_child(room)
	
	current_room = room
	
	var spawn = room.get_node(spawn_point)
	
	player.global_position = spawn.global_position
	
	colorrect.fade_out()
	
	player.state = player.States.idle
