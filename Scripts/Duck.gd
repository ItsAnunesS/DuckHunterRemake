extends KinematicBody2D

var side = 1
var vel = Vector2()
var flyingSpeed = 100
var fallSpeed = 1
var isDuck = true

func _ready():
	randomize()
	$TimerQuack.wait_time = rand_range(1, 3)
	$TimerMovimentation.wait_time = rand_range(0.4, 2)
	$TimerChangeAnimation.wait_time = rand_range(0.6, 1)

func _process(delta):
	position.x += flyingSpeed*side*delta
	position.y -= 140*fallSpeed*delta
	
	if side < 0:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false

func _on_TimerMovimentation_timeout():
	side *= -1

func _on_TimerChangeAnimation_timeout():
	if $AnimatedSprite2D.animation == "Flying Up":
		$AnimatedSprite2D.animation = "Flying Idle"
	elif $AnimatedSprite2D.animation == "Flying Idle":
		$AnimatedSprite2D.animation = "Flying Up"

func _on_TimerDie_timeout():
	$TimerQuack.stop()
	$AnimatedSprite2D.animation = "Dying"
	fallSpeed = -1
	side = 0

func _on_TimerQuack_timeout():
	$AudioDuckQuack.play()

func kill():
	$AnimatedSprite2D.animation = "Scared"
	$TimerDie.start()
