extends Node2D

var world = load("res://World/World.tres")
var maze = load("res://World/Maze.tres")

const CELL_WIDTH = 32
const CELL_HEIGHT = 32
var player_column = 10
var player_row = 10

var the_maze

const BOARD_COLUMNS = 21
const BOARD_ROWS = 21
const BOARD_CENTER_COLUMN = 10
const BOARD_CENTER_ROW = 10

func showMazeCell(dst_column, dst_row, maze_column, maze_row):
	var cell = the_maze[maze_column][maze_row]
	var src_column = 0
	var src_row = BOARD_ROWS
	if(cell.doors[maze.DIRECTION_NORTH]):
		src_column+=BOARD_COLUMNS
	if(cell.doors[maze.DIRECTION_EAST]):
		src_column+=BOARD_COLUMNS*2
	if(cell.doors[maze.DIRECTION_SOUTH]):
		src_row+=BOARD_ROWS
	if(cell.doors[maze.DIRECTION_WEST]):
		src_row+=BOARD_ROWS*2
	for column in range(BOARD_COLUMNS):
		for row in range(BOARD_ROWS):
			terrain_tilemap.set_cell(dst_column+column, dst_row+row, $Templates.get_cell(src_column+column, src_row+row))

var terrain_tilemap
var characters_tilemap
var inner_panel

func _init():
	the_maze = maze.createMaze()

func _ready():
	terrain_tilemap = get_node("Panel/InnerPanel/Terrain")
	characters_tilemap = get_node("Panel/InnerPanel/Characters")
	inner_panel = get_node("Panel/InnerPanel")
	world.make_tile_table(characters_tilemap.tile_set)
	
	for maze_column in range(maze.MAZE_COLUMNS):
		for maze_row in range(maze.MAZE_ROWS):
			showMazeCell(maze_column*BOARD_COLUMNS, maze_row*BOARD_ROWS,maze_column, maze_row)
	show_dude()

func hide_dude():
	characters_tilemap.set_cell(player_column, player_row,-1)
	
func show_dude():
	inner_panel.rect_position = Vector2(CELL_WIDTH * (BOARD_CENTER_COLUMN-player_column)+CELL_WIDTH/2, CELL_HEIGHT * (BOARD_CENTER_ROW-player_row)+CELL_HEIGHT/2)
	characters_tilemap.set_cell(player_column, player_row,characters_tilemap.tile_set.find_tile_by_name("Player"))

func moveDude(deltaX, deltaY):
	hide_dude()
	var next_row = player_row + deltaY
	var next_column = player_column + deltaX
	var tile_id = terrain_tilemap.get_cell(next_column, next_row)
	var terrain_id = world.tile_names[tile_id]
	var terrain_descriptor = world.terrains[terrain_id]
	if(!terrain_descriptor.is_solid):
		player_row=next_row
		player_column=next_column
	show_dude()

func _input(event):
	if event.is_action_pressed("ui_up"):
		moveDude(0,-1)
	if event.is_action_pressed("ui_down"):
		moveDude(0,1)
	if event.is_action_pressed("ui_left"):
		moveDude(-1,0)
	if event.is_action_pressed("ui_right"):
		moveDude(1,0)
