local deny_list = {}
deny_list["ignore"] = true
deny_list["air"] = true
deny_list["default:water_flowing"] = true
deny_list["default:river_water_flowing"] = true
deny_list["default:lava_flowing"] = true
deny_list["default:cloud"] = true
deny_list["mesecons_pistons:piston_normal_on"] = true
deny_list["mesecons_pistons:piston_pusher_normal"] = true
deny_list["mesecons_pistons:piston_sticky_on"] = true
deny_list["mesecons_pistons:piston_pusher_sticky"] = true
deny_list["default:chest_locked_open"] = true
deny_list["default:chest_open"] = true

minetest.register_on_mods_loaded(function()
	for p,v in pairs(minetest.registered_nodes)
	do
		if minetest.registered_nodes[p.."_active"] then
			deny_list[p.."_active"] = true
		end
	end
end)


minetest.register_craftitem("getter:getter",{
	description = "Getter (Right click to get thing that you pointing)",
	groups = {tools = 1},
	inventory_image = "cursor.png",
	liquids_pointable = true,
	stack_max = 1,
	on_place = function(itemstack, placer, pointed_thing)
		if not(placer:is_player()) then
			return
		end
		local pos = minetest.get_pointed_thing_position(pointed_thing, false)
		local node = minetest.get_node(pos)
		if not(minetest.registered_items[node.name]) then
			return
		end
		if deny_list[node.name] then
			return
		end
		if minetest.registered_items[node.name].groups and minetest.registered_items[node.name].groups.unbreakable then
			return
		end
		local inv = placer:get_inventory()
		if inv and not(inv:contains_item("main", node.name)) then
			inv:add_item("main", node.name)
		end
	end,
})
