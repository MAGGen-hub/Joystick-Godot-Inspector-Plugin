@tool
extends Control
## This script and node (demo_control) is used to demonstrate how to work with
## joysticks provided by JoystickInspectorPlugin.

## Hint: by pressing SHIFT while editing value,
## You can magnet it to coordinate grid (axises and points where they cross).

## Common issues:
## 1. If you not seeing joystick: deselect your node/resource,
##    save script if unsaved and select it again.
##    Check if hint_string of your joystic is valid.
## 2. If prop default value is Vector2(X,X), but joystick displays Vector2(0,0):
##    You probably working in @tool script and just created this property,
##    that means it isn't initialised yet and equal to <null>.
##    Use joystick or press revert button to initialise it.

## Default usage: PROPERTY_HINT_TYPE_STRING enables plugin.
## Hint string contains joystick configuration.
@export_custom(PROPERTY_HINT_TYPE_STRING,"")
var basic_joystick:=Vector2(-1,1):
	set(val):basic_joystick =val; print(val)

## Radial coordinate grid. Grid can be set to "grid:basic" or "grid:radial" modes
## Basic is set by default. Radial can be used when keeping vector length
## at the same value is important (SHIFT+LMB).
@export_custom(PROPERTY_HINT_TYPE_STRING,"grid:radial")
var radial_joystick :Vector2:#= Vector2(0,0):
	set(val):
		radial_joystick =val;
		$"TextureRect".material.set_shader_parameter(&"off",val)
		print(val)

## Advanced usage: Joystick can be configured to support biger values.
## Default value pull is [from -Vector2(2,2) to Vector2(2,2)]
## "limit:X" parameter changes value pull to [from -Vector2(X,X) to Vector2(X,X)]
## "div:Y" controls size of coordinate grid cell/segment. Default is 1.0.
## "keep_editor" tells plugin to keep default Vector2 editor visible.
## With next configuration coordinate grid will look like chess board.
@export_custom(PROPERTY_HINT_TYPE_STRING,"grid:basic,limit:8.0,div:2.0,keep_editor:true")
var chess_joystick:=Vector2(1,1)

## Keep in mind that "limit:X" and "div:X" have lower limits: 0.002 and 0.001!
## With "div" >= "limit" coordinate grids will display only main axises.
