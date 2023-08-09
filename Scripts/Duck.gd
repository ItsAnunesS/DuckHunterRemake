extends CharacterBody2D

var side = 1
var vel = Vector2()
var flyingSpeed = 100
var fallSpeed = 1

func _ready():
	randomize()
	$Quack.wait_time = randf_range(1.3, 3)
	$Move.wait_time = randf_range(0.4, 2)
	$Animation.wait_time = randf_range(0.6, 1)

func _process(delta):
	position.x += flyingSpeed*side*delta
	position.y -= 140*fallSpeed*delta
	
	if side < 0:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false

func _on_move_timeout():
	side *= -1

func _on_animation_timeout():
	if $AnimatedSprite2D.animation == "Flying Up":
		$AnimatedSprite2D.animation = "Flying Idle"
	elif $AnimatedSprite2D.animation == "Flying Idle":
		$AnimatedSprite2D.animation = "Flying Up"

func _on_die_timeout():
	$Quack.stop()
	$AnimatedSprite2D.animation = "Dying"
	fallSpeed = -1
	side = 0

func kill():
	$AnimatedSprite2D.animation = "Scared"
	$Die.start()


func _on_quack_timeout():
	$AudioDuckQuack.play()
