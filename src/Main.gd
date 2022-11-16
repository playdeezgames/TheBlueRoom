extends Node2D

var world = load("res://World/World.tres")
var dude = load("res://World/Dude.tres")
var maze = load("res://World/Maze.tres")
var board = load("res://World/Board.tres")

var the_maze

var terrain_tilemap
var characters_tilemap
var inner_panel

func _init():
	the_maze = maze.createMaze()
	maze.chamberize(the_maze)
	maze.doorwayify(the_maze)
	
func _ready():
	terrain_tilemap = get_node("Panel/InnerPanel/Terrain")
	characters_tilemap = get_node("Panel/InnerPanel/Characters")
	inner_panel = get_node("Panel/InnerPanel")
	world.make_tile_table(characters_tilemap.tile_set)
	$BoardRenderer.render_maze(the_maze)
	dude.spawn_dude(the_maze)
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
