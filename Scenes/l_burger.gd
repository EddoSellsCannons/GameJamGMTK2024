extends Area2D

@onready var speed_randomise_timer: Timer = $speedRandomiseTimer
@onready var player_detected_timer: Timer = $playerDetectedTimer

@onready var player_noticed_notif: Sprite2D = $playerNoticedNotif


var rng = RandomNumberGenerator.new()
@export var maxSpeed: float
@export var maxSize: float
var speed: float = 0
var dir = Vector2(0,0)
var size = 100

@onready var gameManager = $".."


func _ready() -> void:
	size = rng.randf_range(maxSize, maxSize)
	scale = Vector2(size/100, size/100)
