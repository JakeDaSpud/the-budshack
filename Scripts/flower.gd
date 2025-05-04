extends Resource
class_name Flower

## Seasons Enum
enum SEASONS {
	UNASSIGNED = 0,
	SPRING = 1,
	SUMMER = 2,
	AUTUMN = 3,
	WINTER = 4
};

## Flower Rarity Enum
enum FLOWER_RARITY {
	LOW = 0,
	MID = 1,
	HIGH = 2,
	SPECIAL = 3
}

## Growth Stage Enum
enum GROWTH_STAGE {
	SEEDLING = 0,
	BUD = 1,
	BLOOM = 2
}

## Map of Colour names to Color Objects
const COLOURS = {
	"UNASSIGNED" : Color("#FF00FF"),
	"RED" : Color("#DC143C"),
	"ORANGE" : Color("#FFA500"),
	"YELLOW" : Color("#FFD700"),
	"GREEN" : Color("#55DD00"),
	"VIOLET" : Color("#EE82EE"),
	"BLUE" : Color("#1E90FF"),
	"PURPLE" : Color("#800080"),
	"PINK" : Color("#FFB6C1"),
	"WHITE" : Color("#FFFFFF"),
	"CREAM" : Color("#FFFDD0"),
	"LAVENDER" : Color("#E6E6FA"),
	"MAGENTA" : Color("#FF00FF"),
	"MAROON" : Color("#800000"),
	"PEACH" : Color("#FFE5B4"),
	"CORAL" : Color("#FF7F50")
}

# ---------- EXPORTED VARIABLES ----------

@export var name : String = "UNNAMED_FLOWER";

## How much the Flower is worth
@export var value : float = -1;

# Growth logic
@export var growth_stage : GROWTH_STAGE = GROWTH_STAGE.SEEDLING;
@export var growth_interval_days : int = 2;
var current_growth : int = 0;
@export var watered_today : bool = false;

## What Season the Flower belongs to
@export var season : SEASONS = SEASONS.UNASSIGNED;

# Head and Stem Models
@export var head_model : Mesh;
@export var stem_model : Mesh;

## What Colours the Flower's Petal Model can be (naturally)
@export var natural_colours : Array[Color] = [COLOURS.UNASSIGNED];

## Colour of the Stem Model
@export var stem_colour : Color = COLOURS.UNASSIGNED;

# ---------- FUNCTIONS ----------

func grow(days_to_progress : int = 1) -> void:
	# Break if the Flower's already grown
	# CHANGE THIS LOGIC IF YOU WANT A DECAY / DIE MECHANIC
	if (growth_stage == GROWTH_STAGE.BLOOM):
		return;
	
	# Only continue if the Flower's been watered since the last day
	if (!watered_today):
		return;
	watered_today = false;
	
	# Increment the growth
	current_growth = current_growth + days_to_progress;
	
	# Process the current growth
	if (current_growth >= growth_interval_days):
		# Dynamic growth_stage increment
		growth_stage = GROWTH_STAGE.get(growth_stage+1);
		# Reset current_growth for the next growth_stage
		current_growth = 0;

func set_head_colour(new_colour : Color) -> void:
	head_model.mesh.material.albedo_color = new_colour;

func set_stem_colour(new_colour : Color) -> void:
	stem_model.mesh.material.albedo_color = new_colour;
