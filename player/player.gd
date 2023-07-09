extends Node3D

@onready var head = get_node("Head/Camera3D")
@onready var gun = get_node("Gun")

var mouse_sensitivity: float = 0.1 # radians/pixel
var speed: float = 10.0
	
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		self.rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity))
		head.rotate_x(deg_to_rad(-event.relative.y * mouse_sensitivity))

		#head.rotate_x(deg_to_rad(event.relative.y * mouse_sensitivity))
		
func _physics_process(delta):
	var velocity: Vector3 = Vector3()
	var direction: Vector3 = get_global_transform().basis.z.normalized()
	
	if Input.is_action_pressed("move_forward"):
		velocity -= direction
	if Input.is_action_pressed("move_backward"):
		velocity += direction
	if Input.is_action_pressed("move_left"):
		velocity += direction.cross(Vector3(0, 1, 0))
	if Input.is_action_pressed("move_right"):
		velocity -= direction.cross(Vector3(0, 1, 0))
	
	position += velocity.normalized() * speed * delta
