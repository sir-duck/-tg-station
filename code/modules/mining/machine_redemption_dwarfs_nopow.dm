/**********************Ore Redemption Unit**************************/
//Turns all the various mining machines into a single unit to speed up mining and establish a point system

/obj/machinery/mineral/ore_redemption/dwarfnp
	name = "dwarfic ore redemption machine"
	desc = "A machine that accepts ore and instantly transforms it into workable material sheets. Only for dwarfs!"
	icon = 'icons/obj/machines/mining_machines.dmi'
	icon_state = "ore_redemption_dwarf-off"
	density = 1
	anchored = 1
	input_dir = NORTH
	output_dir = SOUTH
//	req_access = list(access_mineral_storeroom)
//	var/stack_list[0] //Key: Type.  Value: Instance of type.
//	var/obj/item/weapon/card/id/inserted_id
//	var/points = 0
//	var/ore_pickup_rate = 15
	sheet_per_ore = 1.5
//	var/point_upgrade = 1
//	var/list/ore_values = list(("sand" = 1), ("iron" = 1), ("dmetal" = 10), ("plasma" = 15), ("silver" = 16), ("gold" = 18), ("titanium" = 30), ("uranium" = 30), ("diamond" = 50), ("bluespace crystal" = 50), ("bananium" = 60))
	speed_process = 1

/obj/machinery/mineral/ore_redemption/dwarfnp/New()
	..()
/*	var/obj/item/weapon/circuitboard/machine/B = new /obj/item/weapon/circuitboard/machine/ore_redemption/dwarf(null)
	B.apply_default_parts(src)

/obj/item/weapon/circuitboard/machine/ore_redemption/dwarf
	name = "circuit board (Ore Redemption) dwarf"
	build_path = /obj/machinery/mineral/ore_redemption/dwarfp
	origin_tech = "programming=1;engineering=2" */

/* /obj/machinery/mineral/ore_redemption/dwarf/RefreshParts()
	var/ore_pickup_rate_temp = 15
	var/point_upgrade_temp = 1
	var/sheet_per_ore_temp = 1
	for(var/obj/item/weapon/stock_parts/matter_bin/B in component_parts)
		sheet_per_ore_temp = 0.65 + (0.35 * B.rating)
	for(var/obj/item/weapon/stock_parts/manipulator/M in component_parts)
		ore_pickup_rate_temp = 15 * M.rating
	for(var/obj/item/weapon/stock_parts/micro_laser/L in component_parts)
		point_upgrade_temp = 0.65 + (0.35 * L.rating)
	ore_pickup_rate = ore_pickup_rate_temp
	point_upgrade = point_upgrade_temp
	sheet_per_ore = sheet_per_ore_temp */

/obj/machinery/mineral/ore_redemption/dwarfnp/process()
	if(!panel_open) //If the machine is partially disassembled and/or depowered, it should not process minerals
		var/turf/T = get_step(src, input_dir)
		var/i = 0
		if(T)
			for(var/obj/item/weapon/ore/O in T)
				if (i >= ore_pickup_rate)
					break
				else if (!O || !O.refined_type)
					continue
				else
					process_sheet(O)
					i++
		else
			var/obj/structure/ore_box/B = locate() in T
			if(B)
				for(var/obj/item/weapon/ore/O in B.contents)
					if (i >= ore_pickup_rate)
						break
					else if (!O || !O.refined_type)
						continue
					else
						process_sheet(O)
						i++
		return

/obj/machinery/mineral/ore_redemption/dwarfnp/attackby(obj/item/weapon/W, mob/user, params)
	//if(exchange_parts(user, W))
	//	return

	if(default_pry_open(W))
		return

	if(default_unfasten_wrench(user, W))
		return
	if(default_deconstruction_screwdriver(user, "ore_redemption-open", "ore_redemption", W))
		updateUsrDialog()
		return
	if(default_deconstruction_crowbar(W))
		return

	return ..()

/obj/machinery/mineral/ore_redemption/dwarfnp/on_deconstruction()
	empty_content()

/* /obj/machinery/mineral/ore_redemption/dwarf/proc/SmeltMineral(obj/item/weapon/ore/O)
	if(O.refined_type)
		var/obj/item/stack/sheet/M = O.refined_type
		points += O.points * point_upgrade
		return M
	qdel(O)//No refined type? Purge it.
	return */

/obj/machinery/mineral/ore_redemption/dwarfnp/attack_hand(mob/user)
	if(..())
		return
	interact(user)

/obj/machinery/mineral/ore_redemption/dwarfnp/interact(mob/user)
	var/obj/item/stack/sheet/s
	var/dat

	dat += text("This machine only accepts ore. Gibtonite and Slag are not accepted.<br><br>")
	dat += text("Designed by DwarfCo some time ago...<br><br>")

	for(var/O in stack_list)
		s = stack_list[O]
		if(s.amount > 0)
			if(O == stack_list[1])
				dat += "<br>"		//just looks nicer
			dat += text("[capitalize(s.name)]: [s.amount] <A href='?src=\ref[src];release=[s.type]'>Release</A><br>")

	var/obj/item/stack/sheet/metalstack
	if(/obj/item/stack/sheet/metal in stack_list)
		metalstack = stack_list[/obj/item/stack/sheet/metal]

	var/obj/item/stack/sheet/plasmastack
	if((/obj/item/stack/sheet/mineral/plasma in stack_list))
		plasmastack = stack_list[/obj/item/stack/sheet/mineral/plasma]

	var/obj/item/stack/sheet/mineral/titaniumstack
	if((/obj/item/stack/sheet/mineral/titanium in stack_list))
		titaniumstack = stack_list[/obj/item/stack/sheet/mineral/titanium]

	if(metalstack && plasmastack && min(metalstack.amount, plasmastack.amount))
		dat += text("Plasteel Alloy (Metal + Plasma): <A href='?src=\ref[src];alloytype1=/obj/item/stack/sheet/metal;alloytype2=/obj/item/stack/sheet/mineral/plasma;alloytypeout=/obj/item/stack/sheet/plasteel'>Smelt</A><BR>")
	if(titaniumstack && plasmastack && min(titaniumstack.amount, plasmastack.amount))
		dat += text("Plastitanium Alloy (Titanium + Plasma): <A href='?src=\ref[src];alloytype1=/obj/item/stack/sheet/mineral/titanium;alloytype2=/obj/item/stack/sheet/mineral/plasma;alloytypeout=/obj/item/stack/sheet/mineral/plastitanium'>Smelt</A><BR>")
	dat += text("<br><div class='statusDisplay'><b>Mineral Value List:</b><BR>[get_ore_values()]</div>")

	var/datum/browser/popup = new(user, "console_stacking_machine", "Ore Redemption Machine", 400, 500)
	popup.set_content(dat)
	popup.open()
	return

/* /obj/machinery/mineral/ore_redemption/dwarf/proc/get_ore_values()
	var/dat = "<table border='0' width='300'>"
	for(var/ore in ore_values)
		var/value = ore_values[ore]
		dat += "<tr><td>[capitalize(ore)]</td><td>[value * point_upgrade]</td></tr>"
	dat += "</table>"
	return dat */

/obj/machinery/mineral/ore_redemption/dwarfnp/Topic(href, href_list)
	if(..())
		return
	if(href_list["release"])
		if(!(text2path(href_list["release"]) in stack_list)) return
		var/obj/item/stack/sheet/inp = stack_list[text2path(href_list["release"])]
		var/obj/item/stack/sheet/out = new inp.type()
		var/desired = input("How much?", "How much to eject?", 1) as num
		out.amount = round(min(desired,50,inp.amount))
		if(out.amount >= 1)
			inp.amount -= out.amount
			unload_mineral(out)
		if(inp.amount < 1)
			stack_list -= text2path(href_list["release"])
	else
		usr << "<span class='warning'>Unexpected1. U shouldn't see this, better pres F1.</span>"
	if(href_list["alloytype1"] && href_list["alloytype2"] && href_list["alloytypeout"])
		var/alloytype1 = text2path(href_list["alloytype1"])
		var/alloytype2 = text2path(href_list["alloytype2"])
		var/alloytypeout = text2path(href_list["alloytypeout"])
		if(!(alloytype1 in stack_list)) return
		if(!(alloytype2 in stack_list)) return
		var/obj/item/stack/sheet/stack1 = stack_list[alloytype1]
		var/obj/item/stack/sheet/stack2 = stack_list[alloytype2]
		var/desired = input("How much?", "How much would you like to smelt?", 1) as num
		var/obj/item/stack/sheet/alloyout = new alloytypeout
		alloyout.amount = round(min(desired,50,stack1.amount,stack2.amount))
		if(alloyout.amount >= 1)
			stack1.amount -= alloyout.amount
			stack2.amount -= alloyout.amount
			unload_mineral(alloyout)
	else
		usr << "<span class='warning'>Unexpected1. U shouldn't see this, better pres F1.</span>"
	updateUsrDialog()
	return

/obj/machinery/mineral/ore_redemption/dwarfnp/ex_act(severity, target)
	var/datum/effect_system/spark_spread/s = new /datum/effect_system/spark_spread
	s.set_up(5, 1, src)
	s.start()
	..()

//empty the redemption machine by stacks of at most max_amount (50 at this time) size
/* obj/machinery/mineral/ore_redemption/dwarf/proc/empty_content()
	var/obj/item/stack/sheet/s

	for(var/O in stack_list)
		s = stack_list[O]
		while(s.amount > s.max_amount)
			new s.type(loc,s.max_amount)
			s.use(s.max_amount)
		s.loc = loc
		s.layer = initial(s.layer)
		s.plane = initial(s.plane) */

