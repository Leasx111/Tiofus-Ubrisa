extends CharacterBody2D

class_name Enemy

@export var enemy_sprite : Sprite2D
@export var enemy_collision : CollisionShape2D
@export var enemy_area : CollisionShape2D
@export var enemy_attack_area : CollisionShape2D
@export var enemy_aggro_area : CollisionShape2D
@export var vulnerability_timer : Timer
@export var enemy_health : TextureProgressBar
@export var animation_player : AnimationPlayer
@export var on_screen_notifier : VisibleOnScreenNotifier2D

@export var health : int

@onready var player : Player = $"/root/Game/Player"

const speed : float = 75.0

enum States {idle, chasing, falling, hurt, attacking, dead}

var state: States = States.idle : set = set_state

var player_near : bool = false
var on_screen : bool = false
var direction : Vector2
var pos : Vector2

func _physics_process(delta: float) -> void :
	
	if state != States.dead and player.state != player.States.dead and on_screen :
		
		direction = (player.global_position - self.global_position).normalized()
		
		pos = (player.position - self.position)
		
		if pos.x <= 128 and pos.x >= - 128 :
			
			enemy_health.visible = true
		
		else :
			
			enemy_health.visible = false
		
		if vulnerability_timer.is_stopped() :
			
			velocity.x = direction.x * speed
		
		else :
			
			velocity.x = 0
		
		if not is_on_floor() : 
			
			velocity += get_gravity() * delta
		
		if state not in [States.hurt, States.attacking] :
			
			if velocity == Vector2.ZERO :
				
				state = States.idle
			
			if velocity.y < 0 :
				
				state = States.falling
			
			elif velocity.x != 0 and state != States.falling :
				
				state = States.chasing
			
			if velocity.x > 0 :
				
				flip_sprite("right")
			
			elif velocity.x < 0 :
				
				flip_sprite("left")
		
		else : 
			
			if is_on_floor() :
				
				velocity.x = 0
		
		move_and_slide()

func set_state(new_state : States) -> void :
	
	var _previous_state : States = state
	
	state = new_state
	
	if state == States.idle :
		
		animation_player.play("idle")
	
	elif state == States.chasing :
		
		animation_player.play("run")
	
	elif state == States.falling :
		
		animation_player.play("fall")
	
	elif state == States.hurt :
		
		animation_player.play("hit")
	
	elif state == States.attacking :
		
		animation_player.play("attack")
	
	elif state == States.dead :
		
		animation_player.play("death")

func get_hurt() -> void :
	
	state = States.idle
	
	state = States.hurt
	
	health -= player.damage
	
	enemy_health.value = health
	
	if enemy_health.value <= 0 :
		
		die()


func die() -> void :
	
	state = States.dead
	
	self.player.emit_signal("enemy_killed")

func flip_sprite(facing : String) -> void :
	
	# Flip sprite right
	if facing == "right" :
		
		enemy_sprite.flip_h = false
		
		enemy_attack_area.position.x = abs(enemy_attack_area.position.x) * 1
		enemy_collision.position.x = abs(enemy_collision.position.x) * - 1
		enemy_area.position.x = abs(enemy_area.position.x) * - 1
	
	# Flip sprite left
	else :
		
		enemy_sprite.flip_h = true
		
		enemy_attack_area.position.x = abs(enemy_attack_area.position.x) * -1
		enemy_collision.position.x = abs(enemy_collision.position.x) *  1
		enemy_area.position.x = abs(enemy_area.position.x) *  1

func _on_visible_on_screen_notifier_2d_screen_entered() -> void :
	
	on_screen = true

func _on_visible_on_screen_notifier_2d_screen_exited() -> void :
	
	on_screen = false

func _on_area_2d_2_area_entered(area : Area2D) -> void :
	
	if area.is_in_group("player") and state != States.dead :
		
		state = States.attacking

func _on_area_2d_2_area_exited(area : Area2D) -> void :
	
	if area.is_in_group("player") and not vulnerability_timer.is_stopped() :
		
		state = States.idle

func _on_area_2d_3_area_entered(area : Area2D) -> void :
	
	if area.is_in_group("player_attack") and state != States.dead :
		
		player.attack += 1
		
		player.calc_damage()
		
		self.get_hurt()

func _on_animation_player_animation_finished(anim_name : StringName) -> void :
	
	if anim_name == "hit" :
		
		state = States.idle
	
	elif anim_name == "attack" :
		
		state = States.idle
		
		vulnerability_timer.start()
	
	elif anim_name == "death" :
		
		queue_free()
