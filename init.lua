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
		if minetest.registered_items[node.name].groups and minetest.registered_items[node.name].groups.unbreakable then
			return
		end
		local inv = placer:get_inventory()
		if inv and not(inv:contains_item("main", node.name)) then
			inv:add_item("main", node.name)
		end
	end,
})
