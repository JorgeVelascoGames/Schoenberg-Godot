extends CanvasLayer
class_name PlayerUI

@onready var texture_progress_bar: TextureProgressBar = $Control/ActionTimerBar
@onready var texture_timer: Timer = $Control/ActionTimerBar/TextureTimer


func _ready() -> void:
	_ready_texture_bar()


func _process(delta: float) -> void:
	_process_texture_bar()


#region Progress Bar
func _ready_texture_bar():
	texture_progress_bar.hide()


func start_progress_bar(time : float) -> void:
	texture_progress_bar.show()
	texture_progress_bar.value = 0
	texture_progress_bar.max_value = time
	texture_timer.wait_time = time
	texture_timer.start()


func close_progress_bar() -> void:
	texture_progress_bar.hide()
	texture_timer.stop()


func _process_texture_bar() -> void:
	if not texture_progress_bar.is_visible_in_tree():
		return
	
	texture_progress_bar.value = texture_timer.wait_time - texture_timer.time_left


func _on_texture_timer_timeout() -> void:
	close_progress_bar()
#endregion
