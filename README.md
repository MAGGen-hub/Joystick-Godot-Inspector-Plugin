# Joystick Inspector Plugin

Plugin for Godot Game Engine created to control `Vector2` properties with virtual joystick-like control.

Works like default Godot `int` or `float` properties slider, but in two dimensions.\
Can be used to smoothly adjust 2d values with your mouse in selected range.

To enable joystick for Vector2 property use next code:
```gdscript
@export_custom(PROPERTY_HINT_TYPE_STRING,"") #insert joystick config or leave empty
var basic_joystick:=Vector2(0,0)
```

**Configuring joystick:** Export `hint_string` can be used to configure joystick behaviour.

Configuration parameters:

- `grid:X` - Controls type of joystick coordinate grid. `X` can be set `basic` and `radial` values. Default is `basic`
- `limit:X` - positive float value, specifies maximum value that can be set to `Vector2` property with a joystick. Default is `2.0`, minimal is `0.002`.
- `div:X` - positive float value, specifies size of single cell in coordinate grid. Default is `1.0`, minimal is `0.001`.
- `keep_editor` - boolean value, if `true` displays default `Vector2` property editor under joystick control.

**Additional feature:** Holding `SHIFT` while using joystick will magnet output value to nearest grid axis or place where axises cross. Works with both grid types.