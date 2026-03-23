extends Sprite2D

class_name Door

@onready var room_loader : RoomLoader = $"/root/Game/RoomLoader"
@onready var player : Player = $"/root/Game/Player"
@onready var room_transition : RoomTransition = $"/root/Game/Player/CanvasLayer/RoomTransition"

@export var target_room_path : String
@export var spawn_point : String

func _on_area_2d_area_entered(area: Area2D) -> void:
	
	if area.is_in_group("player") : 
		
		var new_room = load(target_room_path)
		
		await room_loader.call_deferred("change_room", new_room, spawn_point)
