// Include base game scripts
#include maps/mp/_utility;
#include common_scripts/utility;

// Include custom clipstone zombies scripts
#include scripts/zm/clipstonezombies/utils;

statistics(player)
{
    player endon("disconnect");
    level waittill("end_game");

    round = level.round_number - 1;

    // Set the headers for the POST request
    headers = [];
    headers["Content-Type"] = "application/json";
    headers["Api_Key"] = level.Clipstone["api_key"];
    headers["Api_Agent"] = level.Clipstone["api_agent"];

    // Set the wanted data for the POST request
    data = [];
    data["guid"] = player getGUID();
    data["name"] = player.name;
    data["score"] = player.score;
    data["kills"] = player.pers["kills"];
    data["downs"] = player.pers["downs"];
    data["deaths"] = player.pers["deaths"];
    data["suicides"] = player.pers["suicides"];
    data["revives"] = player.pers["revives"];
    data["headshots"] = player.pers["headshots"];
    data["melee_kills"] = player.pers["melee_kills"];
    data["grenade_kills"] = player.pers["grenade_kills"];
    data["total_shots"] = player.pers["total_shots"];
    data["hits"] = player.pers["hits"];
    data["sacrifices"] = player.pers["sacrifices"];
    data["doors_purchased"] = player.pers["doors_purchased"];
    data["distance_traveled"] = player.pers["distance_traveled"];
    data["boards"] = player.pers["boards"];
    data["drops"] = player.pers["drops"];
    data["nuke_pickedup"] = player.pers["nuke_pickedup"];
    data["insta_kill_pickedup"] = player.pers["insta_kill_pickedup"];
    data["full_ammo_pickedup"] = player.pers["full_ammo_pickedup"];
    data["double_points_pickedup"] = player.pers["double_points_pickedup"];
    data["meat_stink_pickedup"] = player.pers["meat_stink_pickedup"];
    data["carpenter_pickedup"] = player.pers["carpenter_pickedup"];
    data["fire_sale_pickedup"] = player.pers["fire_sale_pickedup"];
    data["zombie_blood_pickedup"] = player.pers["zombie_blood_pickedup"];
    data["use_magicbox"] = player.pers["use_magicbox"];
    data["use_pap"] = player.pers["use_pap"];
    data["specialty_armorvest_drank"] = player.pers["specialty_armorvest_drank"];
    data["specialty_quickrevive_drank"] = player.pers["specialty_quickrevive_drank"];
    data["specialty_rof_drank"] = player.pers["specialty_rof_drank"];
    data["specialty_fastreload_drank"] = player.pers["specialty_fastreload_drank"];
    data["specialty_flakjacket_drank"] = player.pers["specialty_flakjacket_drank"];
    data["specialty_additionalprimaryweapon_drank"] = player.pers["specialty_additionalprimaryweapon_drank"];
    data["specialty_longersprint_drank"] = player.pers["specialty_longersprint_drank"];
    data["specialty_deadshot_drank"] = player.pers["specialty_deadshot_drank"];
    data["specialty_scavenger_drank"] = player.pers["specialty_scavenger_drank"];
    data["specialty_finalstand_drank"] = player.pers["specialty_finalstand_drank"];
    data["specialty_grenadepulldeath_drank"] = player.pers["specialty_grenadepulldeath_drank"];
    data["specialty_nomotionsensor"] = player.pers["specialty_nomotionsensor"];
    data["wallbuy_weapons_purchased"] = player.pers["wallbuy_weapons_purchased"];
    data["ammo_purchased"] = player.pers["ammo_purchased"];
    data["upgraded_ammo_purchased"] = player.pers["upgraded_ammo_purchased"];
    data["power_turnedon"] = player.pers["power_turnedon"];
    data["power_turnedoff"] = player.pers["power_turnedoff"];
    data["planted_buildables_pickedup"] = player.pers["planted_buildables_pickedup"];
    data["buildables_built"] = player.pers["buildables_built"];
    data["time_played_total"] = player.pers["time_played_total"];
    data["zdogs_killed"] = player.pers["zdogs_killed"];
    data["zdog_rounds_finished"] = player.pers["zdog_rounds_finished"];
    data["zdog_rounds_lost"] = player.pers["zdog_rounds_lost"];
    data["killed_by_zdog"] = player.pers["killed_by_zdog"];
    data["screechers_killed"] = player.pers["screechers_killed"];
    data["screecher_teleporters_used"] = player.pers["screecher_teleporters_used"];
    data["avogadro_defeated"] = player.pers["avogadro_defeated"];
    data["killed_by_avogadro"] = player.pers["killed_by_avogadro"];
    data["prison_brutus_killed"] = player.pers["prison_brutus_killed"];
    data["buried_ghost_killed"] = player.pers["buried_ghost_killed"];
    data["tomb_mechz_killed"] = player.pers["tomb_mechz_killed"];
    data["tomb_dig"] = player.pers["tomb_dig"];
    data["language"] = player.pers["language"];

    // Send the POST request and wait until the request is finished for the result
    request = httpPost("http://127.0.0.1:8000/api/vanilla/statistics", jsonSerialize(data, 4), headers);
    request waittill("done", result);

    // Parse the json from the POST request
    statistics = jsonParse(result);

    // Dump the json request for debugging
    jsonDump("statistics", result, 4);

    // Loop through the result to tell the player a pretty board
    foreach(message in statistics["result"])
        player tell(message);
}

getStatistics(player)
{
    // Set the headers data we want to send with the request
    headers = [];
    headers["Content-Type"] = "application/json";
    headers["Api_Key"] = level.Clipstone["api_key"];
    headers["Api_Agent"] = level.Clipstone["api_agent"];

    // Set the data we want to send with the request
    data = [];
    data["guid"] = player getGUID();
    data["language"] = player.pers["language"];

    // Send the request and waittill its completed
    request = httpPost("http://127.0.0.1:8000/api/vanilla/getStatistics", jsonSerialize(data, 4), headers);
    request waittill("done", result);

    // Parse the json object from the request
    getStatistics = jsonParse(result);

    // Dump the json request to see if their are any issues
    jsonDump("getStatistics", result, 4);

    // Loop through the result to tell the player a pretty board
    foreach(message in getStatistics["result"])
        player tell(message);
}

getTopStatistics(player, args)
{
    // Set the headers data we want to send with the request
    headers = [];
    headers["Content-Type"] = "application/json";
    headers["Api_Key"] = level.Clipstone["api_key"];
    headers["Api_Agent"] = level.Clipstone["api_agent"];

    // Set the data we want to send with the request
    data = [];
    data["stats_type"] = args[1];
    data["language"] = player.pers["language"];

    // Send the request and waittill its completed
    request = httpPost("http://127.0.0.1:8000/api/vanilla/getTopStatistics", jsonSerialize(data, 4), headers);
    request waittill("done", result);

    // Parse the json object from the request
    getTopStatistics = jsonParse(result);

    // Dump the json object from the request to see if their are any issues
    jsonDump("getTopStatistics", result, 4);

    // Loop therough the result to tell the player a pretty board
    foreach (message in getTopStatistics["result"])
        player tell(message);
}
