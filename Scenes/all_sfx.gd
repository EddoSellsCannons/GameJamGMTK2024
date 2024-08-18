extends Node

@onready var hurt_sound: AudioStreamPlayer = $hurtSound
@onready var eat_enemy_sound: AudioStreamPlayer = $eatEnemySound
@onready var shoot_poison: AudioStreamPlayer = $shootPoison
@onready var shoot_laser: AudioStreamPlayer = $shootLaser

func playHurtSound():
	hurt_sound.play()
	
func playEatSound():
	eat_enemy_sound.play()
	
func playShootPoisonSound():
	shoot_poison.play()
	
func playShootLaserSound():
	shoot_laser.play()
