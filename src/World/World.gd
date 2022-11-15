extends Resource

var tiles_table = {}
var tile_names = {}
func make_tile_table(tile_set):
	for id in tile_set.get_tiles_ids():
		tiles_table[tile_set.tile_get_name(id)]=id
		tile_names[id]=tile_set.tile_get_name(id)

var terrains = {
	"Floor":{
		"is_solid": false
	},
	"Solid":{
		"is_solid": true
	},
	"North Wall":{
		"is_solid": true
	},
	"South Wall":{
		"is_solid": true
	},
	"East Wall":{
		"is_solid": true
	},
	"West Wall":{
		"is_solid": true
	},
	"North Doorway":{
		"is_solid": false
	},
	"South Doorway":{
		"is_solid": false
	},
	"East Doorway":{
		"is_solid": false
	},
	"West Doorway":{
		"is_solid": false
	},
	"Northeast Inside Corner":{
		"is_solid": true
	},
	"Northwest Inside Corner":{
		"is_solid": true
	},
	"Southeast Inside Corner":{
		"is_solid": true
	},
	"Southwest Inside Corner":{
		"is_solid": true
	},
	"Northeast Outside Corner":{
		"is_solid": true
	},
	"Northwest Outside Corner":{
		"is_solid": true
	},
	"Southeast Outside Corner":{
		"is_solid": true
	},
	"Southwest Outside Corner":{
		"is_solid": true
	}
}
