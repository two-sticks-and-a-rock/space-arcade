extends Node


func get_kills_with_leading_zeros(kills: int, displayed_zeros: int) -> String:
	var kills_copy = kills
	var num_nonzeros : int = 0
	while kills_copy > 0:
		num_nonzeros += 1
		kills_copy /= 10
	
	var prepend_zeros = str(kills)
	while num_nonzeros < displayed_zeros:
		num_nonzeros += 1
		prepend_zeros = "0" + prepend_zeros
	
	return prepend_zeros

func float_to_displayed_time(timer_time : float) -> String:
	var minutes : int = int(timer_time / 60.0)
	var seconds : int = int(timer_time) % 60
	var minutes_with_leading_zeros = str(minutes) if minutes >= 10 else "0"+str(minutes)
	var seconds_with_leading_zeros = str(seconds) if seconds >= 10 else "0"+str(seconds)
	return minutes_with_leading_zeros + ":" + seconds_with_leading_zeros

func exp_decay(a: Vector2, b: Vector2, decay: float, delta: float):
	return b+(a-b)*exp(-decay*delta)

func exp_velocity_decay(a: Vector2, b: Vector2, decay: float):
	return b+(a-b)*exp(-decay)
