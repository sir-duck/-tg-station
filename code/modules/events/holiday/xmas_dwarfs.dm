/datum/round_event_control/dwarf
	name = "Some shit happened! (Not a Christmas)"
	holidayID = DWARF_EVENT
	typepath = /datum/round_event/dwarf
	weight = -1
	max_occurrences = 10

/datum/round_event/dwarf
	var/mob/living/carbon/human/dwarf //who is our shitty dwarfs?

/datum/round_event/dwarf/announce()
	priority_announce("12314567890!", "Unknown Transmission")

/datum/round_event/dwarf/start()
	for(var/mob/M in dead_mob_list)
		spawn(0)
			var/response = alert(M, "DWARF NEEDED YOY! Do you want to be a part of some cool staff?", "Ho ho ho, moterfucker!", "Yes", "No")
			if(response == "Yes" && M && M.client && M.stat == DEAD)
				dwarf = new /mob/living/carbon/human(pick(dwarf_start))
				dwarf.key = M.key
				qdel(M)

				dwarf.real_name = "Santa Claus"
				dwarf.name = "Santa Claus"
				dwarf.mind.name = "Santa Claus"
				dwarf.mind.assigned_role = "Santa"
				dwarf.mind.special_role = "Santa"

				dwarf.hair_style = "Long Hair"
				dwarf.facial_hair_style = "Full Beard"
				dwarf.hair_color = "FFF"
				dwarf.facial_hair_color = "FFF"
				dwarf.dna.add_mutation(DWARFISM)
				dwarf.dna.species.species_traits = list(NOBREATH)

				dwarf.equip_to_slot_or_del(new /obj/item/clothing/under/color/red, slot_w_uniform) //TODO - NORAMLNIY EQUP.
				dwarf.equip_to_slot_or_del(new /obj/item/clothing/suit/space/santa, slot_wear_suit)
				dwarf.equip_to_slot_or_del(new /obj/item/clothing/head/santa, slot_head)
				dwarf.equip_to_slot_or_del(new /obj/item/clothing/mask/breath, slot_wear_mask)
				dwarf.equip_to_slot_or_del(new /obj/item/clothing/gloves/color/red, slot_gloves)
				dwarf.equip_to_slot_or_del(new /obj/item/clothing/shoes/sneakers/red, slot_shoes)
				dwarf.equip_to_slot_or_del(new /obj/item/weapon/tank/internals/emergency_oxygen/double, slot_belt)
				dwarf.equip_to_slot_or_del(new /obj/item/device/radio/headset/heads/captain, slot_ears)
				dwarf.equip_to_slot_or_del(new /obj/item/weapon/storage/backpack/santabag, slot_back)
				dwarf.equip_to_slot_or_del(new /obj/item/device/flashlight, slot_r_store)

				var/obj/item/weapon/card/id/gold/dwarfcard = new(dwarf)
				var/datum/job/captain/J = new/datum/job/captain
				dwarfcard.access = J.get_access()
				dwarf.equip_to_slot_or_del(dwarfcard, slot_wear_id)

				dwarf.update_icons() //зачем.?

				var/obj/item/weapon/storage/backpack/explorer = dwarf.back

				var/datum/objective/dwarf_objective = new()
				dwarf_objective.explanation_text = "Bring joy and presents to the station1112!"
				dwarf_objective.completed = 1 //lets cut our santas some slack.
				dwarf_objective.owner = dwarf.mind
				dwarf.mind.objectives += dwarf_objective

				dwarf << "<span class='boldannounce'>BADASS! Вставить что-нибудь пристойное в этот текст! Помимо всего, ЖТБ - плохой кодер.</span>"
