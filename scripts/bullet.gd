extends Area2D

var speed = 700

func _physics_process(delta):
	position += transform.x * speed * delta
	
# conectamos el nodo bullet eligiendo _on_body_entered() para las colisiones de la balas
func _on_body_entered(body):
	queue_free() 	
	
	if body.has_method("take_damage"):
		body.take_damage()
