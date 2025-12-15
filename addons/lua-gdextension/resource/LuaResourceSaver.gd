class_name LuaResourceSaver
extends ResourceFormatSaver

func _get_recognized_extensions(resource: Resource) -> PackedStringArray:
	if resource is LuaResource:
		return ["lua"]
	return []

func _recognize(resource: Resource) -> bool:
	return resource is LuaResource

func _save(resource: Resource, path: String, _flags: int) -> Error:
	var file: FileAccess = FileAccess.open(path, FileAccess.WRITE)
	if file:
		file.store_string(resource.source_code)
		file.close()
		return OK
	return ERR_CANT_CREATE
