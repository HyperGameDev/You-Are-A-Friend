extends StaticBody3D

@export var friend_name = "Friend"

var convo_state = 0
var friend_hover = false
var dialogue_hover = true
var dialogue_close_hover = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$"Dialogue/Friend Dialogue/Friend Name".set_text(friend_name)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
