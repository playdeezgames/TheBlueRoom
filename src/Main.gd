extends Node2D

const BOARD_COLUMNS = 15
const BOARD_ROWS = 15

var column = 7
var row = 7

var terrain_descriptors = [
	{
		solid = false
	},
	{
		solid = true
	}
]

func placeDude():
	$Pieces.set_cell(column, row, 0)
	
func hideDude():
	$Pieces.set_cell(column, row, -1)
	
func initializeBoard():
	for x in range(BOARD_COLUMNS):
		for y in range(BOARD_ROWS):
			$Board.set_cell(x,y,1 if x==0 || y==0 || x==BOARD_COLUMNS-1 || y==BOARD_ROWS-1 else 0)
	
func _ready():
	initializeBoard()
	placeDude()
	
func moveDude(deltaX, deltaY):
	hideDude()
	var next_column=column+deltaX
	var next_row=row+deltaY
	var terrain = $Board.get_cell(next_column, next_row)
	var descriptor = terrain_descriptors[terrain]
	if(descriptor.solid):
		next_column=column
		next_row=row
	column=next_column
	row = next_row
	placeDude()

func _input(event):
	if event.is_action_pressed("ui_up"):
		moveDude(0,-1)
	if event.is_action_pressed("ui_down"):
		moveDude(0,1)
	if event.is_action_pressed("ui_left"):
		moveDude(-1,0)
	if event.is_action_pressed("ui_right"):
		moveDude(1,0)
	
