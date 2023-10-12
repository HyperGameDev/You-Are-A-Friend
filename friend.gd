extends StaticBody3D

@export var friend_name = "Friend"

var convo_state = 0
var friend_nearby = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$"DialogueBox/Friend Dialogue/Friend Name".set_text(friend_name)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("activate") and friend_nearby == true:
		$"DialogueBox".visible = true
		$"..".player_state = $"..".PlayerStates.DIALOGUE
		convo_state = 1
		
	if Input.is_action_just_pressed("deactivate") and $"DialogueBox".visible == true:
		$"DialogueBox".visible = false
		$"..".player_state = $"..".PlayerStates.NORMAL
		convo_state = 0
	_dialogue_exiter(delta)
	_raycast_checker(delta)
	
func _raycast_checker(delta):
	friend_nearby = false
	
func _dialogue_exiter(delta):
	if friend_nearby == false:
		$"DialogueBox".visible = false
