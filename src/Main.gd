extends Node2D

var world = load("res://World/World.tres")
var maze = load("res://World/Maze.tres")
var dude = load("res://World/Dude.tres")
var board = load("res://World/Board.tres")

var the_maze
func showMazeCell(dst_column, dst_row, maze_column, maze_row):
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
	for column in range(board.BOARD_COLUMNS):
		for row in range(board.BOARD_ROWS):
			terrain_tilemap.set_cell(dst_column+column, dst_row+row, $Templates.get_cell(src_column+column, src_row+row))

var terrain_tilemap
var characters_tilemap
var inner_panel

func _init():
	the_maze = maze.createMaze()
	var _maze_layout = maze.chamberize(the_maze)
	pass

func _ready():
	terrain_tilemap = get_node("Panel/InnerPanel/Terrain")
	characters_tilemap = get_node("Panel/InnerPanel/Characters")
	inner_panel = get_node("Panel/InnerPanel")
	world.make_tile_table(characters_tilemap.tile_set)
	
	for maze_column in range(maze.MAZE_COLUMNS):
		for maze_row in range(maze.MAZE_ROWS):
			showMazeCell(maze_column*board.BOARD_COLUMNS, maze_row*board.BOARD_ROWS,maze_column, maze_row)
	dude.show_dude(inner_panel, characters_tilemap)


func _input(event):
	if event.is_action_pressed("ui_up"):
		dude.moveDude(inner_panel, characters_tilemap, terrain_tilemap, world, 0,-1)
	if event.is_action_pressed("ui_down"):
		dude.moveDude(inner_panel, characters_tilemap, terrain_tilemap, world, 0,1)
	if event.is_action_pressed("ui_left"):
		dude.moveDude(inner_panel, characters_tilemap, terrain_tilemap, world, -1,0)
	if event.is_action_pressed("ui_right"):
		dude.moveDude(inner_panel, characters_tilemap, terrain_tilemap, world, 1,0)
