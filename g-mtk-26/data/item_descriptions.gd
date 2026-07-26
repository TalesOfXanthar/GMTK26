extends Node

var item_desc := {
	"locked": {
		"sprite": "res://visual_assets/item_sprites/empty.png",
		"moveable" : false,
		"template": {"locked":null}
	},
	"empty": {
		"sprite": "res://visual_assets/item_sprites/empty.png",
		"sprite_damaged": "res://visual_assets/item_sprites/damaged_empty.png",
		"moveable" : false,
		"template": {"empty":{"damaged":false}}
	},
	"fuel_canister": {
		"sprite": "res://visual_assets/item_sprites/fuel_canister.png",
		"moveable" : true,
		"tags": [
			
		],
		"template": {"fuel":5}
	},
	"thruster": {
		"sprite": "res://visual_assets/item_sprites/booster.png",
		"sprite_damaged": "res://visual_assets/item_sprites/damaged_booster.png",
		"moveable" : true,
		"tags": [
			
		],
		"template": {"thruster":{"damaged": false}}
	},
	"repair_scrap": {
		"sprite": "res://visual_assets/item_sprites/repair_scrap.png",
		"moveable" : true,
		"tags": [
			
		],
		"template": {"repair_scrap":":)"}
	},
	"translator": {
		"sprite": "res://visual_assets/item_sprites/translator.png",
		"moveable" : true,
		"tags": [
			
		],
		"template": {"translator":":)"}
	},
}

var slot_neighbors = {
	0: [1],
	1: [0, 2, 5],
	2: [1, 6],
	3: [],
	4: [],
	5: [1, 6, 9],
	6: [2, 5, 7, 10],
	7: [6, 11],
	8: [],
	9: [5, 10, 13],
	10: [6, 9, 11, 14],
	11: [7, 10],
	12: [13],
	13: [9, 12, 14],
	14: [10, 13],
	15: [],
}
