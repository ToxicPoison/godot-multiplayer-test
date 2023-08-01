extends Node2D

@onready var tilemap = $TileMap

const EDGE_TILE := Vector2i(0, 0)
const ROCK_TILE := Vector2i(1, 0)
var width : int = 64
var height : int = 32
var solid : float = 0.0
var seed = 0

@onready var noise = FastNoiseLite.new()

func generate_terrain():
	noise.fractal_octaves = 2
	noise.frequency = 0.1
	
	for x in range(-1, width+1):
		tilemap.set_cell(0, Vector2i(x, -1), 0, EDGE_TILE, 0)
		tilemap.set_cell(0, Vector2i(x, height), 0, EDGE_TILE, 0)
	for y in range(-1, height+1):
		tilemap.set_cell(0, Vector2i(-1, y), 0, EDGE_TILE, 0)
		tilemap.set_cell(0, Vector2i(width, y), 0, EDGE_TILE, 0)
	
	for x in width:
		for y in height:
			var pos := Vector2i(x, y)
			var density : float = noise.get_noise_2dv(pos)
			if density > solid:
				tilemap.set_cell(0, pos, 0, ROCK_TILE, 0)
				
#	for x in range():
#		for y in range():
#			pass
