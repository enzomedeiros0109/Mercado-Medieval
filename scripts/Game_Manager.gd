extends Node

signal points_changed(new_points: int)
signal game_over()

var points: int       = 0
var total_correct: int = 0
var total_wrong: int   = 0

const POINTS_CORRECT = 100
const POINTS_WRONG   = 50


func add_correct():
	total_correct += 1
	points += POINTS_CORRECT
	emit_signal("points_changed", points)

func add_wrong():
	total_wrong += 1
	points = max(0, points - POINTS_WRONG)
	emit_signal("points_changed", points)
