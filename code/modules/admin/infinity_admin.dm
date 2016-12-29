/datum/admins/verb/reset_vote()
	set category = "Admin"
	set name = "Reset Vote"
	set desc = "Resets Vote"

	if(!check_rights())
		return

	SSvote.reset()

	message_admins("<span class='adminnotice'>[key_name_admin(usr)] �������(�) �����������.</span>")
	log_admin("[key_name_admin(usr)] �������(�) �����������.")
	feedback_add_details("admin_verb","RSVT")

//Port From /Bay/station.
/client/proc/roll_dices()
	set category = "Fun"
	set name = "Roll Dice"
	if(!check_rights(R_FUN))
		return

	var/sum = input("������� ��� �� ������ �������?") as num
	var/side = input("������ ����� ������.") as num
	if(!side)
		side = 6
	if(!sum)
		sum = 2

	var/dice = num2text(sum) + "d" + num2text(side)

	if(alert("������ �� �� �������� ����� ���� � ���� ������?",,"��", "���") == "��")
		world << "<h2 style=\"color:#A50400\">���� ������� ��������� �����!</h2>"

	var/result = roll(dice)

	if(alert("������ �� �� �������� ����� ���� � ���������� ������?",,"��", "���") == "��")
		world << "<h2 style=\"color:#A50400\">���� ������� ��������� ����� [dice], ��������� [result]</h2>"

	message_admins("[key_name_admin(src)] ��������(�) ��������� ����� [dice], ��������� - [result]", 1)