extends Area2D

var duck

func _ready():
	pass

func _process(delta):
	pass

func _on_body_entered(body):
	duck = body

func _input(event):
	if Input.is_action_just_pressed("Shoot"):
		$AudioStreamPlayer2D.play()
		if duck != null:
			duck.kill()
