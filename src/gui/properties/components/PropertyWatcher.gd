extends Node
class_name PropertyWatcher

@export var target: CanvasItem
## Comparison on the parent AbstractProperty's value. Refer to the value as [value].
@export var condition: String
@export var property: StringName

func _ready() -> void:
	var parent := get_parent() as AbstractProperty
	parent.value_changed.connect(_watcher_update_value)

func _watcher_update_value(value: Variant) -> void:
	var expression := Expression.new()
	expression.parse(condition, ["value"])
	var result := expression.execute([value]) as bool
	if target is AbstractProperty and property == "enabled":
		target.set_input_state(result)
	else:
		target.set(property, result)
