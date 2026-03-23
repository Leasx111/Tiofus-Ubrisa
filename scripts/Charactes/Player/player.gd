extends CharacterBody2D

class_name Player

@export var player_collision_shape : CollisionShape2D
@export var animation_player : AnimationPlayer
@export var attack_area : CollisionShape2D
@export var player_area : CollisionShape2D
@export var player_exp: TextureProgressBar
@export var death_screen : DeathScreen
@export var room_transition : RoomTransition
@export var roomloader : RoomLoader
@export var viking_rage_screen : ColorRect
@export var level_menu : LevelMenu
@export var tutorial: TutorialMenu
@export var skill_tree_menu : Control
@export var exit_menu : ExitMenu
@export var player_sprite : Sprite2D
@export var viking_rage_timer : Timer
@export var vulnerability_timer : Timer
@export var invincibility_timer : Timer

@onready var enemy : Enemy = Enemy.new()
@onready var first_room : PackedScene = preload("res://scenes/Rooms/room_1.tscn")

const jump_speed : int = -400
const speed : int = 200

enum States {idle, running, jumping, falling, hurt, first_attack, second_attack, third_attack, rolling, dead}

var state: States = States.idle : set = set_state

var direction : float
var attack : int = 0
var damage : int

signal enemy_killed

func _ready() -> void :
	
	SaveData.save_requested.connect(_on_save_requested)
	SaveData.load_requested.connect(_on_load_requested)
	
	connect("enemy_killed", _on_enemy_killed)
	
	player_exp.max_value = SaveData.player_data.max_XP
	player_exp.value = SaveData.player_data.current_xp
	
	room_transition.visible = true
	player_exp.visible = true

func _physics_process(delta: float) -> void :
	
	if state != States.dead :
		
		direction = Input.get_axis("move_left", "move_right")
		
		if not room_transition.visible :
			
			velocity.x = direction * speed
		
		if not is_on_floor() :
			
			velocity += get_gravity() * delta
		
		if state not in [States.hurt, States.first_attack, States.second_attack, States.third_attack, States.rolling] :
			
			if velocity == Vector2.ZERO :
				
				state = States.idle
			
			if velocity.y > 0 :
				
				state = States.falling
			
			elif velocity.x != 0 and state != States.jumping :
				
				state = States.running
			
			if velocity.x > 0 :
				
				flip_sprite("right")
			
			elif velocity.x < 0 :
				
				flip_sprite("left")
		
		else :
			
			if is_on_floor() :
				
				velocity.x = 0
			
			if state == States.rolling :
				
				velocity.x = SaveData.player_data.sprite_flipped * speed
		
		move_and_slide()

func set_state(new_state : States) -> void :
	
	var previous_state : States = state
	
	state = new_state
	
	if state == States.idle :
		
		animation_player.play("idle")
	
	elif state == States.jumping :
		
		animation_player.play("jump")
	
	elif previous_state == States.jumping :
		
		animation_player.play("fall")
	
	elif state == States.running :
		
		animation_player.play("run")
	
	elif state == States.hurt :
		
		animation_player.play("hit")
	
	if state == States.first_attack :
		
		animation_player.play("attack")
	
	elif state == States.second_attack :
		
		animation_player.play("attack_2")
	
	elif state == States.third_attack :
		
		animation_player.play("attack_3")
	
	elif state == States.rolling :
		
		animation_player.play("slide")
	
	elif state == States.dead :
		
		animation_player.play("death")

func get_hurt() -> void :
	
	state = States.hurt
	
	invincible(true)
	
	if SaveData.player_data.viking_rage > 0 :
		
		SaveData.player_data.viking_rage -= 1
		
		if SaveData.player_data.viking_rage <= 1 :
			
			viking_rage_screen.visible = true
			
			viking_rage_timer.start()
	
	else :
		
		die()

func invincible(toggle : bool) -> void :
	
	if toggle :
		
		player_area.set_deferred("disabled", true)
		
		collision_layer = 2
		collision_mask = 2
	
	else :
		
		player_area.set_deferred("disabled", false)
		
		collision_layer = 1
		collision_mask = 1

func die() -> void :
	
	if state != States.dead :
		
		state = States.dead

func calc_damage() -> void :
	
	var luck_value = SaveData.player_data.luck
	
	var crit : int = randi() % (100 - luck_value)
	
	damage = 20 + (SaveData.player_data.attack * 2)
	
	if  crit == 0 :
		
		damage *= 2

func respawn() -> void :
	
	attack = 0
	SaveData.player_data.viking_rage = 1
	
	death_screen.visible = false
	level_menu.visible = false
	viking_rage_screen.visible = false
	
	if SaveData.player_data.last_checkpoint :
		
		await room_transition.fade_in()
		
		room_transition.fade_out()
		
		state = States.idle
		position = SaveData.player_data.last_checkpoint.position
	
	else :
		
		roomloader.change_room(first_room, "spawn_left")

func set_last_checkpoint(checkpoint : Checkpoint) -> void :
	
	SaveData.player_data.last_checkpoint = checkpoint
	
	SaveData.player_data.last_checkpoint_position = checkpoint.global_position
	
	SaveData.player_data.last_checkpoint_image = checkpoint.save_image
	
	SaveData.player_data.viking_rage = SaveData.player_data.max_viking_rage

func flip_sprite(facing : String) -> void :
	
	# Flip sprite right
	if facing == "right" :
		
		SaveData.player_data.sprite_flipped = 1
		
		player_sprite.flip_h = false
		
		attack_area.position.x = abs(attack_area.position.x) * 1
		player_collision_shape.position.x = abs(player_collision_shape.position.x) * - 1
		player_area.position.x = abs(player_area.position.x) * - 1
	
	# Flip sprite left
	else :
		
		SaveData.player_data.sprite_flipped = - 1
		
		player_sprite.flip_h = true
		
		attack_area.position.x = abs(attack_area.position.x) * - 1
		player_collision_shape.position.x = abs(player_collision_shape.position.x) * 1
		player_area.position.x = abs(player_area.position.x) * 1

func gain_exp() -> void :
	
	var tween_increase_value = get_tree().create_tween()
	
	tween_increase_value.tween_property(player_exp, "value", player_exp.value + 100, 1)
	
	await tween_increase_value.finished
	
	if player_exp.value >= player_exp.max_value :
		
		var tween_value = get_tree().create_tween()
		
		tween_value.tween_property(player_exp, "value", player_exp.value - player_exp.max_value, 0.2)
		
		SaveData.player_data.max_XP = player_exp.max_value * 1.25
		
		player_exp.max_value = SaveData.player_data.max_XP
		
		await  tween_value.finished
		
		@warning_ignore("narrowing_conversion")
		SaveData.player_data.current_xp = player_exp.value
		
		SaveData.player_data.level += 1
		
		SaveData.player_data.level_up_points += 1

func _on_animation_player_animation_finished(anim_name : StringName) -> void :
	
	if anim_name == "hit" :
		
		state = States.idle
		
		attack = 0
		
		invincibility_timer.start()
	
	if anim_name == "attack" or anim_name == "attack_2" or anim_name == "attack_3" or anim_name == "slide" :
		
		state = States.idle
		
		if anim_name == "attack" :
			
			if attack == 2 :
				
				state = States.second_attack
			
			else :
				
				attack = 0
		
		elif anim_name == "attack_2" :
			
			if attack == 4 :
				
				state = States.third_attack
			
			else :
				
				attack = 0
		
		elif anim_name == "attack_3" :
			
			attack = 0
		
		elif anim_name == "slide" :
			
			vulnerability_timer.wait_time = 1.5 - (0.015 * SaveData.player_data.temperance)
			
			vulnerability_timer.start()
	
	elif anim_name == "death" :
		
		death_screen.showable = true
		death_screen.fade_in()

func _on_area_2d_2_area_entered(area : Area2D) -> void :
	
	if area.is_in_group("enemy_attack") and state != States.dead :
		
		get_hurt()

func _on_save_requested() -> void :
	
	ResourceSaver.save(SaveData.player_data, "user://test_data" + str(SaveData.current_data) + ".tres")

func _on_load_requested() -> void :
	
	if FileAccess.file_exists("user://test_data" + str(SaveData.current_data) + ".tres") == false :
		
		print(Error.ERR_DOES_NOT_EXIST)
	
	else :
		
		SaveData.player_data = ResourceLoader.load("user://test_data" + str(SaveData.current_data) + ".tres")

func _on_enemy_killed() -> void :
	
	viking_rage_timer.stop()
	
	viking_rage_screen.visible = false
	
	gain_exp()

func _on_invincibility_timer_timeout() -> void:
	
	invincible(false)

func _on_viking_rage_timer_timeout() -> void:
	
	die()

func _input(event: InputEvent) -> void :
	
	if event.is_action_pressed("jump") and is_on_floor() :
		
		velocity.y = jump_speed
		
		state = States.jumping
	
	if event.is_action_pressed("slide") and is_on_floor() and vulnerability_timer.is_stopped() :
		
		state = States.rolling
	
	if event.is_action_released("attack") and state != States.rolling and state != States.hurt and state != States.dead :
		
		if attack == 1 :
			
			attack = 2
		
		elif attack == 3 :
			
			attack = 4
		
		elif attack == 0 :
			
			state = States.first_attack
	
	if event.is_action_released("toggle_skill_tree") and tutorial.visible == false and state != States.dead :
		
		skill_tree_menu.visible = not skill_tree_menu.visible
