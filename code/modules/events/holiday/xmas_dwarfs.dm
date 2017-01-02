/datum/round_event_control/dwarf
	name = "Some shit happened! (Not a Christmas)"
	holidayID = DWARF_EVENT
	typepath = /datum/round_event/dwarf
	weight = 150
	max_occurrences = 1
	earliest_start = 20000

/datum/round_event/dwarf
	var/mob/living/carbon/human/dwarf //who is our shitty dwarfs?

/datum/round_event/dwarf/announce()
	priority_announce("12314567890!", "Unknown Transmission")

/datum/round_event/santa/start()
	for(var/mob/M in dead_mob_list)
		spawn(0)
			var/response = alert(M, "DWARF NEEDED YOY! Do you want to be a part of some cool staff?", "Ho ho ho, moterfucker!", "Yes", "No")
			if(response == "Yes" && M && M.client && M.stat == DEAD && !santa)
				dwarf = new /mob/living/carbon/human/dwarf(pick(dwarf_start)) //TODO - нормальное место спавна сделать, на астероиде
				dwawrf.key = M.key
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

				dwarf.equip_to_slot_or_del(new /obj/item/clothing/under/color/red, slot_w_uniform)
				dwarf.equip_to_slot_or_del(new /obj/item/clothing/suit/space/santa, slot_wear_suit)
				dwarf.equip_to_slot_or_del(new /obj/item/clothing/head/santa, slot_head)
				dwarf.equip_to_slot_or_del(new /obj/item/clothing/mask/breath, slot_wear_mask)
				dwarf.equip_to_slot_or_del(new /obj/item/clothing/gloves/color/red, slot_gloves)
				dwarf.equip_to_slot_or_del(new /obj/item/clothing/shoes/sneakers/red, slot_shoes)
				dwarf.equip_to_slot_or_del(new /obj/item/weapon/tank/internals/emergency_oxygen/double, slot_belt)
				dwarf.equip_to_slot_or_del(new /obj/item/device/radio/headset/heads/captain, slot_ears)
				dwarf.equip_to_slot_or_del(new /obj/item/weapon/storage/backpack/santabag, slot_back)
				dwarf.equip_to_slot_or_del(new /obj/item/device/flashlight, slot_r_store) //most blob spawn locations are really dark.

				var/obj/item/weapon/card/id/gold/dwarfacard = new(dwarf)
				//santacard.update_label("Santa Claus", "Santa")
				var/datum/job/captain/J = new/datum/job/captain
				dwarfcard.access = J.get_access()
				dwarf.equip_to_slot_or_del(dwarfcard, slot_wear_id)

				santa.update_icons()

				var/obj/item/weapon/storage/backpack/bag = dwarf.back

				var/datum/objective/dwarf_objective = new()
				dwar_objective.explanation_text = "Bring joy and presents to the station1112!"
				dwar_objective.completed = 1 //lets cut our santas some slack.
				dwar_objective.owner = dwar.mind
				dwar.mind.objectives += dwar_objective
				var/obj/effect/proc_holder/spell/targeted/area_teleport/teleport/telespell = new(dwar)
				telespell.clothes_req = 0 //santa robes aren't actually magical.
				dwarf.mind.AddSpell(telespell) //does the station have chimneys? WHO KNOWS!

				dwarf << "<span class='boldannounce'>234You are Santa! Your objective is to bring joy to the people on this station. You can conjure more presents using a spell, and there are several presents in your bag.</span>"
