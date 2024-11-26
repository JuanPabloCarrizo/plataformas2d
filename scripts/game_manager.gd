extends Node

var score = 0
var total_coins = 17

signal score_updated
signal level_completed

func add_point():
	score += 1
	print(score)
	emit_signal("score_updated", score)

	if score >= total_coins:
		emit_signal("level_completed")
