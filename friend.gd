extends StaticBody3D

@export var friend_name = "Friend"

var convo_state = 0
var friend_nearby = false
var dialogue_hover = true
var dialogue_close_hover = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$"Dialogue/Friend Dialogue/Friend Name".set_text(friend_name)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("activate") and friend_nearby == true:
		$"Dialogue".visible = true
		input_ray_pickable = false
		convo_state = 1
		
	if $"Dialogue".visible:
		await get_tree().create_timer(0.1).timeout
		if Input.is_action_just_released("Mouse") and dialogue_close_hover == true:
			$"Dialogue".visible = false
			dialogue_close_hover = false
			convo_state = 0
			input_ray_pickable = true
		
func _on_mouse_entered():
	if convo_state == 0:
		friend_nearby = true

func _on_mouse_exited():
	friend_nearby = false

func _on_close_panel_top_mouse_entered():
	dialogue_close_hover = true

func _on_close_panel_l_mouse_entered():
	dialogue_close_hover = true
	
func _on_close_panel_r_mouse_entered():
	dialogue_close_hover = true

func _on_close_panel_top_mouse_exited():
	dialogue_close_hover = false

func _on_close_panel_l_mouse_exited():
	dialogue_close_hover = false

func _on_close_panel_r_mouse_exited():
	dialogue_close_hover = false
