#pragma once

#include <godot_cpp/variant/variant.hpp>
#include <sol/sol.hpp>

using namespace godot;

namespace luagdextension {

#define LUA_PROPERTY_LIST_NAME "_lua_property_list"

bool filter__variant__whitelist(const Variant &variant,
                                const sol::stack_object &key);

} // namespace luagdextension
