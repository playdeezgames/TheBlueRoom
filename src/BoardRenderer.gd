extends Node

export(NodePath) var terrain_tilemap
var maze = load("res://World/Maze.tres")
var board = load("res://World/Board.tres")

func render_template(dst_column, dst_row, columns, rows, src_column, src_row):
	for column in range(columns):
		for row in range(rows):
			get_node(terrain_tilemap).set_cell(dst_column+column, dst_row+row, $Templates.get_cell(src_column+column, src_row+row))
	
func render_passageway(the_maze, dst_column, dst_row, maze_column, maze_row):
	var cell = the_maze[maze_column][maze_row]
	var src_column = 0
	var src_row = board.BOARD_ROWS
	if(cell.doors[maze.DIRECTION_NORTH]):
		src_column+=board.BOARD_COLUMNS
	if(cell.doors[maze.DIRECTION_EAST]):
		src_column+=board.BOARD_COLUMNS*2
	if(cell.doors[maze.DIRECTION_SOUTH]):
		src_row+=board.BOARD_ROWS
	if(cell.doors[maze.DIRECTION_WEST]):
		src_row+=board.BOARD_ROWS*2
	render_template(dst_column, dst_row, board.BOARD_COLUMNS, board.BOARD_ROWS, src_column, src_row)
	if cell.doorways[maze.DIRECTION_NORTH]:
		render_template(dst_column+7, dst_row, 7,1,70,0)
	if cell.doorways[maze.DIRECTION_SOUTH]:
		render_template(dst_column+7, dst_row+20, 7,1,70,20)
	if cell.doorways[maze.DIRECTION_WEST]:
		render_template(dst_column, dst_row+7, 1,7,63,7)
		if cell.doorways[maze.DIRECTION_EAST]:
			render_template(dst_column+20, dst_row+7, 1,7,83,7)

func render_chamber(the_maze, dst_column, dst_row, maze_column, maze_row):
	render_template(dst_column, dst_row, board.BOARD_COLUMNS, board.BOARD_ROWS, 0, 0)
	var cell = the_maze[maze_column][maze_row]
	if(cell.doors[maze.DIRECTION_NORTH]):
		if cell.doorways[maze.DIRECTION_NORTH]:
			render_template(dst_column+7, dst_row, 7,1,28,0)
		else:
			render_template(dst_column+7, dst_row, 7,1,49,0)
	if(cell.doors[maze.DIRECTION_SOUTH]):
		if cell.doorways[maze.DIRECTION_SOUTH]:
			render_template(dst_column+7, dst_row+20, 7,1,28,20)
		else:
			render_template(dst_column+7, dst_row+20, 7,1,49,20)
	if(cell.doors[maze.DIRECTION_WEST]):
		if cell.doorways[maze.DIRECTION_WEST]:
			render_template(dst_column, dst_row+7, 1,7,21,7)
		else:
			render_template(dst_column, dst_row+7, 1,7,42,7)
	if(cell.doors[maze.DIRECTION_EAST]):
		if cell.doorways[maze.DIRECTION_EAST]:
			render_template(dst_column+20, dst_row+7, 1,7,41,7)
		else:
			render_template(dst_column+20, dst_row+7, 1,7,62,7)

func render_maze(the_maze):
	for maze_column in range(maze.MAZE_COLUMNS):
		for maze_row in range(maze.MAZE_ROWS):
			if the_maze[maze_column][maze_row].chamber:
				render_chamber(the_maze, maze_column*board.BOARD_COLUMNS, maze_row*board.BOARD_ROWS,maze_column, maze_row)
			else:
				render_passageway(the_maze, maze_column*board.BOARD_COLUMNS, maze_row*board.BOARD_ROWS,maze_column, maze_row)

func _ready():
	pass
