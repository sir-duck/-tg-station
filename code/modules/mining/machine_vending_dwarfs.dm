/**********************Mining Equipment Vendor**************************/

/obj/machinery/mineral/equipment_vendor/dwarfp
	name = "dwarfic mining equipment vendor"
	desc = "An equipment vendor for miners, points collected at an ore redemption machine can be spent here. Designed by DwarfCo many years ago..."
	icon = 'icons/obj/machines/mining_machines.dmi'
	icon_state = "mining_dwarf"
	density = 1
	anchored = 1
	obj/item/weapon/card/id/inserted_id
	list/prize_list = list( //if you add something to this, please, for the love of god, use tabs and not spaces.
		new /datum/data/mining_equipment("Stimpack",			/obj/item/weapon/reagent_containers/hypospray/medipen/stimpack,			100),
		new /datum/data/mining_equipment("Stimpack Bundle",		/obj/item/weapon/storage/box/medipens/utility,							400),
		new /datum/data/mining_equipment("Whiskey",				/obj/item/weapon/reagent_containers/food/drinks/bottle/whiskey,			400),
		new /datum/data/mining_equipment("Cigar",				/obj/item/clothing/mask/cigarette/cigar/havana,							300),
		new /datum/data/mining_equipment("Shelter Capsule",		/obj/item/weapon/survivalcapsule,										500),
		new /datum/data/mining_equipment("GAR scanners",		/obj/item/clothing/glasses/meson/gar,									1000),
		new /datum/data/mining_equipment("Explorer's Webbing",	/obj/item/weapon/storage/belt/mining,									1000),
		new /datum/data/mining_equipment("Survival Medipen",	/obj/item/weapon/reagent_containers/hypospray/medipen/survival,			1000),
		new /datum/data/mining_equipment("Brute First-Aid Kit",	/obj/item/weapon/storage/firstaid/brute,								1200),
		new /datum/data/mining_equipment("Tracking Implant Kit",/obj/item/weapon/storage/box/minertracker,								1200),
		new /datum/data/mining_equipment("Jaunter",				/obj/item/device/wormhole_jaunter,										1500),
		new /datum/data/mining_equipment("Kinetic Crusher",		/obj/item/weapon/twohanded/required/mining_hammer,						1500),
		new /datum/data/mining_equipment("Kinetic Accelerator",	/obj/item/weapon/gun/energy/kinetic_accelerator,						1500),
		new /datum/data/mining_equipment("Resonator",			/obj/item/weapon/resonator,												1600),
		new /datum/data/mining_equipment("Fulton Pack",			/obj/item/weapon/extraction_pack,										2000),
		new /datum/data/mining_equipment("Lazarus Injector",	/obj/item/weapon/lazarus_injector,										2000),
		new /datum/data/mining_equipment("Silver Pickaxe",		/obj/item/weapon/pickaxe/silver,										2000),
		new /datum/data/mining_equipment("Jetpack Upgrade",		/obj/item/weapon/tank/jetpack/suit,										4000),
		new /datum/data/mining_equipment("Space Cash",			/obj/item/stack/spacecash/c1000,										2000),
		new /datum/data/mining_equipment("Mining Hardsuit",		/obj/item/clothing/suit/space/hardsuit/mining,							4000),
		new /datum/data/mining_equipment("Diamond Pickaxe",		/obj/item/weapon/pickaxe/diamond,										4000),
		new /datum/data/mining_equipment("Super Resonator",		/obj/item/weapon/resonator/upgraded,									5000),
		new /datum/data/mining_equipment("KA White Tracer Rounds",	/obj/item/borg/upgrade/modkit/tracer,								200),
		new /datum/data/mining_equipment("KA Adjustable Tracer Rounds",	/obj/item/borg/upgrade/modkit/tracer/adjustable,				300),
		new /datum/data/mining_equipment("KA Super Chassis",	/obj/item/borg/upgrade/modkit/chassis_mod,								500),
		new /datum/data/mining_equipment("KA Hyper Chassis",	/obj/item/borg/upgrade/modkit/chassis_mod/orange,						600),
		new /datum/data/mining_equipment("KA Range Increase",	/obj/item/borg/upgrade/modkit/range,									2000),
		new /datum/data/mining_equipment("KA Damage Increase",	/obj/item/borg/upgrade/modkit/damage,									2000),
		new /datum/data/mining_equipment("KA Cooldown Decrease",/obj/item/borg/upgrade/modkit/cooldown,									2000),
		new /datum/data/mining_equipment("KA AoE Damage",		/obj/item/borg/upgrade/modkit/aoe/mobs,									4000),
		new /datum/data/mining_equipment("Point Transfer Card",	/obj/item/weapon/card/mining_point_card,								1000),
		new /datum/data/mining_equipment("Jump Boots",			/obj/item/clothing/shoes/bhop,											5000),
		new /datum/data/mining_equipment("Science Goggles",       	/obj/item/clothing/glasses/science,									500),
		new /datum/data/mining_equipment("Monkey Cube",				/obj/item/weapon/reagent_containers/food/snacks/monkeycube,			600),
		new /datum/data/mining_equipment("Toolbelt",				/obj/item/weapon/storage/belt/utility,	    						700),
		new /datum/data/mining_equipment("Sulphuric Acid",			/obj/item/weapon/reagent_containers/glass/beaker/sulphuric,			500),
		new /datum/data/mining_equipment("Brute First-Aid Kit",		/obj/item/weapon/storage/firstaid/brute,							600),
		new /datum/data/mining_equipment("Grey Slime Extract",		/obj/item/slime_extract/grey,										1000),
		new /datum/data/mining_equipment("Modification Kit",    	/obj/item/borg/upgrade/modkit/trigger_guard,						1700),
		new /datum/data/mining_equipment("The Liberator's Legacy",  /obj/item/weapon/storage/box/rndboards,								3000),
		)

/datum/data/mining_equipment
	equipment_name = "generic"
	equipment_path = null
	cost = 0

/datum/data/mining_equipment/New(name, path, cost)
	src.equipment_name = name
	src.equipment_path = path
	src.cost = cost

/obj/machinery/mineral/equipment_vendor/dwarfp/New()
	..()
	var/obj/item/weapon/circuitboard/machine/B = new /obj/item/weapon/circuitboard/machine/mining_equipment_vendor/dwarfp(null)
	B.apply_default_parts(src)

/obj/item/weapon/circuitboard/machine/mining_equipment_vendor/dwarfp
	name = "circuit board (Mining Equipment Vendor)"
	build_path = /obj/machinery/mineral/equipment_vendor/dwarfp
	origin_tech = "programming=1;engineering=3"
	req_components = list(
							/obj/item/weapon/stock_parts/console_screen = 1,
							/obj/item/weapon/stock_parts/matter_bin = 3)

/obj/machinery/mineral/equipment_vendor/dwarfp/power_change()
	..()
	update_icon()

/obj/machinery/mineral/equipment_vendor/dwarfp/update_icon()
	if(powered())
		icon_state = initial(icon_state)
	else
		icon_state = "[initial(icon_state)]-off"
	return

/obj/machinery/mineral/equipment_vendor/dwarfp/attack_hand(mob/user)
	if(..())
		return
	interact(user)

/obj/machinery/mineral/equipment_vendor/dwarfp/interact(mob/user)
	var/dat
	dat +="<div class='statusDisplay'>"
	if(istype(inserted_id))
		dat += "You have [inserted_id.mining_points] mining points collected. <A href='?src=\ref[src];choice=eject'>Eject ID.</A><br>"
	else
		dat += "No ID inserted.  <A href='?src=\ref[src];choice=insert'>Insert ID.</A><br>"
	dat += "</div>"
	dat += "<br><b>Equipment point cost list:</b><BR><table border='0' width='300'>"
	for(var/datum/data/mining_equipment/prize in prize_list)
		dat += "<tr><td>[prize.equipment_name]</td><td>[prize.cost]</td><td><A href='?src=\ref[src];purchase=\ref[prize]'>Purchase</A></td></tr>"
	dat += "</table>"

	var/datum/browser/popup = new(user, "miningvendor", "Mining Equipment Vendor", 400, 350)
	popup.set_content(dat)
	popup.open()
	return

/obj/machinery/mineral/equipment_vendor/dwarfp/Topic(href, href_list)
	if(..())
		return
	if(href_list["choice"])
		if(istype(inserted_id))
			if(href_list["choice"] == "eject")
				inserted_id.loc = loc
				inserted_id.verb_pickup()
				inserted_id = null
		else if(href_list["choice"] == "insert")
			var/obj/item/weapon/card/id/I = usr.get_active_held_item()
			if(istype(I))
				if(!usr.drop_item())
					return
				I.loc = src
				inserted_id = I
			else usr << "<span class='danger'>No valid ID.</span>"
	if(href_list["purchase"])
		if(istype(inserted_id))
			var/datum/data/mining_equipment/prize = locate(href_list["purchase"])
			if (!prize || !(prize in prize_list))
				return
			if(prize.cost > inserted_id.mining_points)
			else
				inserted_id.mining_points -= prize.cost
				new prize.equipment_path(src.loc)
				feedback_add_details("mining_equipment_bought",
					"[src.type]|[prize.equipment_path]")
				// Add src.type to keep track of free golem purchases
				// seperately.
	updateUsrDialog()
	return

/obj/machinery/mineral/equipment_vendor/dwarfp/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/weapon/mining_voucher))
		RedeemVoucher(I, user)
		return
	if(istype(I,/obj/item/weapon/card/id))
		var/obj/item/weapon/card/id/C = usr.get_active_held_item()
		if(istype(C) && !istype(inserted_id))
			if(!usr.drop_item())
				return
			C.loc = src
			inserted_id = C
			interact(user)
		return
	if(default_deconstruction_screwdriver(user, "mining-open", "mining", I))
		updateUsrDialog()
		return
	if(default_deconstruction_crowbar(I))
		return
	return ..()

/obj/machinery/mineral/equipment_vendor/dwarfp/ex_act(severity, target)
	var/datum/effect_system/spark_spread/s = new /datum/effect_system/spark_spread
	s.set_up(5, 1, src)
	s.start()
	if(prob(50 / severity) && severity < 3)
		qdel(src)


