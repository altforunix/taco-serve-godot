extends Node

class_name EntityAI

enum STATE { IDLE, PATROL, CHASE, INTERACT, DEAD }

var current_state = STATE.IDLE
var entity_type: String
var threat_level: int
var speed: float
var detection_range: float = 15.0
var attack_range: float = 2.0

var target: Node3D = null
var patrol_points: Array = []
var current_patrol_index: int = 0
var idle_timer: float = 0.0
var detection_timer: float = 0.0

signal entity_detected(entity: Node3D)
signal entity_attacking(entity: Node3D)
signal entity_defeated(entity: Node3D)

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	match current_state:
		STATE.IDLE:
			idle_timer += delta
			if idle_timer > 3.0:
				change_state(STATE.PATROL)
				idle_timer = 0.0
		STATE.PATROL:
			patrol(delta)
		STATE.CHASE:
			if target:
				chase_target(delta)
			else:
				change_state(STATE.PATROL)
		STATE.INTERACT:
			pass

func change_state(new_state: int) -> void:
	current_state = new_state
	match new_state:
		STATE.IDLE:
			idle_timer = 0.0
		STATE.PATROL:
			pass
		STATE.CHASE:
			entity_detected.emit(self)

func patrol(delta: float) -> void:
	if patrol_points.is_empty():
		return
	
	var target_point = patrol_points[current_patrol_index]
	var direction = (target_point - global_position).normalized()
	
	if global_position.distance_to(target_point) < 0.5:
		current_patrol_index = (current_patrol_index + 1) % patrol_points.size()


func chase_target(delta: float) -> void:
	if not target:
		return
	
	var distance = global_position.distance_to(target.global_position)
	if distance > detection_range:
		target = null
		change_state(STATE.PATROL)
		return
	
	if distance < attack_range:
		entity_attacking.emit(self)


func set_patrol_path(points: Array) -> void:
	patrol_points = points


func detect_player(player: Node3D) -> void:
	target = player
	change_state(STATE.CHASE)
