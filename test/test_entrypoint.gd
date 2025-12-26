extends SceneTree

const LUA_TEST_DIR = "res://lua_tests"
const GDSCRIPT_TEST_DIR = "res://gdscript_tests"

func _process(_delta):
	var all_success = true

	print("Starting Lua GDExtension tests (runtime: ", LuaState.get_lua_runtime(), ")")
	for gdscript in DirAccess.get_files_at(GDSCRIPT_TEST_DIR):
		if gdscript.ends_with(".uid"):
			continue
		print("> ", gdscript, ":")
		var file_name = str(GDSCRIPT_TEST_DIR, "/", gdscript)
		var obj = load(file_name).new()
		if obj is Node:
			root.add_child(obj)
		for method in obj.get_method_list():
			var method_name = method.name
			if method_name.begins_with("test"):
				# optional per-test setup
				if obj.has_method("_setup"):
					obj._setup()
				# actual test
				if not obj.call(method_name):
					all_success = false
					printerr("  ! ", method_name)
				else:
					print("  ✓ ", method_name)
		if obj is Node:
			obj.queue_free()
	
	quit(0 if all_success else -1)
