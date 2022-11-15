extends Node2D

var world = load("res://World/World.tres")

const MAZE_COLUMNS = 8
const MAZE_ROWS = 8
const CELL_WIDTH = 32
const CELL_HEIGHT = 32

enum {DIRECTION_NORTH, DIRECTION_EAST, DIRECTION_SOUTH, DIRECTION_WEST, DIRECTION_COUNT}

var player_column = 10
var player_row = 10

func columnStep(column, _row, direction):
	match direction:
		DIRECTION_EAST:
			return column+1
		DIRECTION_WEST:
			return column-1
		_: 
			return column
	
func rowStep(_column, row, direction):
	match direction:
		DIRECTION_NORTH:
			return row-1
		DIRECTION_SOUTH:
			return row+1
		_: 
			return row
			
func oppositeDirection(direction):
	return (direction + DIRECTION_COUNT/2) % DIRECTION_COUNT

func createMaze():
	var maze=[]
	while maze.size()<MAZE_COLUMNS:
		var mazeColumn = []
		while mazeColumn.size()<MAZE_ROWS:
			mazeColumn.push_back({doors=[false,false,false,false], inside=false})
		maze.push_back(mazeColumn)
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var column = rng.randi_range(0,MAZE_COLUMNS-1)
	var row = rng.randi_range(0,MAZE_ROWS-1)
	maze[column][row].inside=true
	var remaining = MAZE_COLUMNS * MAZE_ROWS - 1
	while(remaining>0):
		column = rng.randi_range(0,MAZE_COLUMNS-1)
		row = rng.randi_range(0,MAZE_ROWS-1)
		if(!maze[column][row].inside):
			var directions=[]
			for direction in range(DIRECTION_COUNT):
				var nextColumn = columnStep(column, row, direction)
				var nextRow = rowStep(column,row, direction)
				if(nextColumn>=0 && nextRow>=0 && nextColumn<MAZE_COLUMNS && nextRow<MAZE_ROWS && maze[nextColumn][nextRow].inside):
					directions.push_back(direction)
			if(!directions.empty()):
				var direction = directions[rng.randi_range(0,directions.size()-1)]
				var nextColumn = columnStep(column, row, direction)
				var nextRow = rowStep(column,row, direction)
				maze[column][row].doors[direction]=true
				maze[nextColumn][nextRow].doors[oppositeDirection(direction)]=true
				maze[column][row].inside=true
				remaining-=1
	return maze

var the_maze

const BOARD_COLUMNS = 21
const BOARD_ROWS = 21
func showMazeCell(dst_column, dst_row, maze_column, maze_row):
	var cell = the_maze[maze_column][maze_row]
	var src_column = 0
	var src_row = BOARD_ROWS
	if(cell.doors[DIRECTION_NORTH]):
		src_column+=BOARD_COLUMNS
	if(cell.doors[DIRECTION_EAST]):
		src_column+=BOARD_COLUMNS*2
	if(cell.doors[DIRECTION_SOUTH]):
		src_row+=BOARD_ROWS
	if(cell.doors[DIRECTION_WEST]):
		src_row+=BOARD_ROWS*2
	for column in range(BOARD_COLUMNS):
		for row in range(BOARD_ROWS):
			terrain_tilemap.set_cell(dst_column+column, dst_row+row, $Templates.get_cell(src_column+column, src_row+row))

var terrain_tilemap
var characters_tilemap
var inner_panel

func _init():
	the_maze = createMaze()

func _ready():
	terrain_tilemap = get_node("Panel/InnerPanel/Terrain")
	characters_tilemap = get_node("Panel/InnerPanel/Characters")
	inner_panel = get_node("Panel/InnerPanel")
	for maze_column in range(MAZE_COLUMNS):
		for maze_row in range(MAZE_ROWS):
			showMazeCell(maze_column*BOARD_COLUMNS, maze_row*BOARD_ROWS,maze_column, maze_row)
	showDude()

func hideDude():
	characters_tilemap.set_cell(player_column, player_row,-1)
func showDude():
	inner_panel.rect_position = Vector2(CELL_WIDTH * (10-player_column), CELL_HEIGHT * (10-player_row))
	characters_tilemap.set_cell(player_column, player_row,characters_tilemap.tile_set.find_tile_by_name("Player"))

func _input(event):
	if event.is_action_pressed("ui_up"):
		hideDude()
		player_row-=1
		showDude()
	if event.is_action_pressed("ui_down"):
		hideDude()
		player_row+=1
		showDude()
	if event.is_action_pressed("ui_left"):
		hideDude()
		player_column-=1
		showDude()
	if event.is_action_pressed("ui_right"):
		hideDude()
		player_column+=1
		showDude()
