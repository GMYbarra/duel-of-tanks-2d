extends CharacterBody2D

@onready var ShootEffect = get_parent().get_node("ShootEffect")
@onready var ExplosionEffect = get_parent().get_node("ExplosionEffect")

var speed = 500
var rotation_speed = 5
const SHOOT_INTERVAL = 2.0 # Intervalo de 2 segundos
var time_since_last_shot = SHOOT_INTERVAL  # Inicializamos para que permita disparar al inicio

# seleccion la escena a instanciar y apretar control para que genere la constante
const BULLET = preload("res://scenes/bullet.tscn")
@onready var shooting_point: Marker2D = $CollisionShape2D/shooting_point

func _physics_process(delta):
	var rotation_direction = Input.get_axis("p2_left","p2_right")
	rotation += rotation_direction * rotation_speed * delta
	
	var direction = Input.get_axis("p2_down","p2_up")
	#valor negativo de la direccion por la direccion de la bala
	velocity = -direction * speed * transform.x
	move_and_slide()
	
	# Actualizamos el temporizador
	time_since_last_shot += delta
	
	if Input.is_action_pressed("p2_shoot") and time_since_last_shot >= SHOOT_INTERVAL:
		shoot()
		time_since_last_shot = 0  # Reiniciamos el tiempo después de disparar
	

func shoot():
	ShootEffect.play()
	var bullet = BULLET.instantiate()
	bullet.global_position = shooting_point.global_position
	bullet.rotation = rotation
	#para corregir el sentido del bala
	bullet.speed = - bullet.speed
	get_parent().add_child(bullet)

func take_damage():
	ExplosionEffect.play()
	queue_free()
	get_parent().increment_p1_score()
	get_parent().respawn_p2()
