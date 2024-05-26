extends Control

@onready var hurt_overlay = $HurtOverlay
@onready var health_bar_bg = $HealthBarBG
@onready var health_bar = $HealthBar
@onready var game_over = $GameOver

var hurt_tween : Tween


func _ready():
	health_bar.value = GameState.get_value("health")
	health_bar_bg.value = health_bar.value
	game_over.hide()


#func _process(_delta):
#	$KeyCounter.text = str(GameState.get_value("key"))


func hurt(damage: float):
	health_bar.value -= damage
	GameState.set_value("health", health_bar.value)
	
	hurt_overlay.modulate = Color.WHITE
	if hurt_tween:
		hurt_tween.kill()
	hurt_tween = create_tween()
	hurt_tween.parallel().tween_property(hurt_overlay, "modulate", Color.TRANSPARENT, 0.5)
	
	hurt_tween.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	hurt_tween.parallel().tween_property(health_bar_bg, "value", health_bar.value, 0.6)


func show_gameover():
	game_over.show()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_restart_button_pressed():
	GameState.set_value("health", 100)
	get_tree().reload_current_scene()


func _on_quit_button_pressed():
	get_tree().quit()
