extends RefCounted

var lua_state: LuaState


func _init():
	lua_state = LuaState.new()
	lua_state.open_libraries()
	lua_state.globals.clear()
	lua_state.globals.UnrestrictedClass = UnrestrictedClass
	lua_state.globals.RestrictedClass = RestrictedClass


func test_unrestricted_class() -> bool:
	assert(lua_state.do_string("return UnrestrictedClass:new()._private_value") == 500)
	assert(lua_state.do_string("return UnrestrictedClass:new().public_value") == 100)
	assert(lua_state.do_string("return UnrestrictedClass:new():_private_method()") == 321)
	assert(lua_state.do_string("return UnrestrictedClass:new():public_method()") == 123)
	assert(lua_state.do_string("""
		return UnrestrictedClass:new():get("_private_value")
	""") == 500)
	return true


func test_restricted_class() -> bool:
	assert(lua_state.do_string("return RestrictedClass:new()._private_value") == null)
	assert(lua_state.do_string("return RestrictedClass:new().public_value") == 100)
	assert(lua_state.do_string("return RestrictedClass:new()._private_method") == null)
	assert(lua_state.do_string("return RestrictedClass:new():public_method()") == 123)
	assert(lua_state.do_string("return RestrictedClass:new().get") == null)
	return true


class UnrestrictedClass:
	var _private_value = 500
	var public_value = 100
	func _private_method(): return 321
	func public_method(): return 123


class RestrictedClass:
	static func _lua_property_list() -> Array[StringName]: 
		return ["new", "public_value", "public_method"]
	var _private_value = 500
	var public_value = 100
	func _private_method(): return 321
	func public_method(): return 123
