/datum/twitch_event
	/// name of event
	var/event_name = ""
	/// duration of the event
	var/event_duration = 10 MINUTES
	/// event flags
	var/event_flags = TWITCH_AFFECTS_STREAMER
	///amount of people we affect if its random
	var/random_count = 0
	///list of targets
	var/list/targets = list()
	///the tag tied to this event, should make these be defines at some point
	var/id_tag
	///should we announce this event
	var/announce = TRUE

/datum/twitch_event/proc/run_event(name)
	targets = list() //clear targets each time, if you for some reason dont want this then just add your own var on the type
	if(event_flags & TWITCH_AFFECTS_STREAMER)
		targets += get_mob_by_ckey("taocat")

	if(event_flags & TWITCH_AFFECTS_ALL)
		targets += GLOB.alive_player_list

	if(event_flags & TWITCH_AFFECTS_RANDOM)
		var/list/living_players = GLOB.alive_player_list
		for(var/num in 1 to random_count)
			var/mob/living/picked = pick(living_players)
			targets += picked
			living_players -= picked

	if(announce)
		minor_announce("[event_name] has just been triggered by [name].", "The Observers")

/datum/twitch_event/proc/end_event()
	return
