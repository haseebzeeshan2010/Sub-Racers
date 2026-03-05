@tool
extends Control
class_name CarouselContainer


# 11 Export variables for various options and settings [1]
@export var spacing: float = 20.0

#@export var wraparound_enabled: bool = false
#@export var wraparound_radius: float = 300.0
#@export var wraparound_height: float = 50.0

# Export range variables to control min/max values and scaling dropoff
@export_range(0.0, 1.0) var opacity_strength: float = 0.35
@export_range(0.0, 1.0) var scale_strength: float = 0.25
@export_range(0.0, 1.0) var scale_min: float = 0.1

@export var smoothing_speed: float = 6.5
@export var selected_index: int = 0
@export var follow_button_focus: bool = false

@export var position_offset_node: Control = null 

func _process(delta: float) -> void:
	# Check if offset node is set and has children before running further code [3]
	if !position_offset_node or position_offset_node.get_child_count() == 0:
		return
	
	# Stop the selected_index from changing to a value that isn't possible
	selected_index = clamp(selected_index, 0, position_offset_node.get_child_count() - 1)

	# Main logic: for loop that cycles through all offset node's children
	for child in position_offset_node.get_children():
		var child_index = child.get_index()
		var distance = child_index - selected_index

		var position_x = 0.0
		if child_index > 0:
			position_x = position_offset_node.get_child(child.get_index()-1).position.x + position_offset_node.get_child(child.get_index()-1).size.x + spacing

		# Immediately update position (no lerping), centering Y axis by using negative half size [6]
		child.position = Vector2(position_x, -child.size.y/2)
		
		child.pivot_offset = Vector2(0,0)
		var target_scale = 1 - (scale_strength * abs(child.get_index() - selected_index))
		target_scale = clamp(target_scale,scale_min,1.0)
		child.scale = lerp(child.scale, Vector2.ONE * target_scale, smoothing_speed*delta)
		
		var target_opacity = 1.0 - (opacity_strength * abs(child.get_index()-selected_index))
		target_opacity = clamp(target_opacity, 0.0, 1.0)
		child.modulate.a = lerp(child.modulate.a, target_opacity, smoothing_speed*delta)
		
		if child.get_index() == selected_index:
			child.z_index = 1
		else:
			child.z_index = -abs(child.get_index()-selected_index)
			
		if follow_button_focus and child.has_focus():
			selected_index = child.get_index()

	# Center carousel within container width and height
	var selected_child = position_offset_node.get_child(selected_index)
	var target_x = -(selected_child.position.x + selected_child.size.x / 2.0 - size.x / 2.0)
	var target_y = -(selected_child.position.y + selected_child.size.y / 2.0 - size.y / 2.0)
	position_offset_node.position.x = lerp(position_offset_node.position.x, target_x, smoothing_speed * delta)
	position_offset_node.position.y = lerp(position_offset_node.position.y, target_y, smoothing_speed * delta)

# Custom functions to externalize navigating this container with one line of code [10]
func move_left() -> void:
	selected_index = clampi(selected_index - 1, 0, position_offset_node.get_child_count() - 1)

func move_right() -> void:
	selected_index = clampi(selected_index + 1, 0, position_offset_node.get_child_count() - 1)
