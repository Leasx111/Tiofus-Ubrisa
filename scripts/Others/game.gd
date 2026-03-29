extends Node2D

class_name Game

@export var first_room : PackedScene
@export var roomloader : RoomLoader
@export var tutorial: TutorialMenu
@export var player: Player


func _ready() -> void :
	
	await roomloader.change_room(first_room, "spawn_left")
	
	if SaveData.load_game != 0:
		
		SaveData.emit_signal("load_requested")
		
		SaveData.load_game = 0
		
		player.position = SaveData.player_data.last_checkpoint_position
	
	else : 
		
		await tutorial.fade_in()

func _input(event: InputEvent) -> void :
	
	if event.is_action_pressed("toggle_exit_menu") :
		
		tutorial.fade_out()
