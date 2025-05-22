// Include base game scripts
#include maps/mp/_utility;
#include common_scripts/utility;

banPlayer(player, args)
{
    // Set the headers data we want to send with the request
    headers = [];
    headers["Content-Type"] = "application/json";
    headers["Api_Key"] = level.Clipstone["api_key"];
    headers["Api_Agent"] = level.Clipstone["api_agent"];

    // Set the data we want to send with the request
    data = [];
    data["staff_guid"] = player getGUID();
    data["player_name"] = args[1];
    data["language"] = player.pers["language"];

    // Send the request and waittill its completed
    request = httpPost("http://127.0.0.1:8000/api/vanilla/banPlayer", jsonSerialize(data, 4), headers);
    request waittill("done", result);

    // Parse the json object from the request
    banPlayer = jsonParse(result);

    // Dump the json object to see if their are any issues
    jsonDump("banPlayer", result, 4);

    // Loop through the result to tell the player a pretty board
    foreach (message in banPlayer["result"])
        player tell(message);
}

godmode(player)
{
    // Set the headers data we want to send with the request
    headers = [];
    headers["Content-Type"] = "application/json";
    headers["Api_Key"] = level.Clipstone["api_key"];
    headers["Api_Agent"] = level.Clipstone["api_agent"];

    // Set the data we want to send with the request
    data = [];
    data["staff_guid"] = player getGUID();
    data["language"] = player.pers["language"];

    // Send the request and waittill its completed
    request = httpPost("http://127.0.0.1:8000/api/vanilla/godmode", jsonSerialize(data, 4), headers);
    request waittill("done", result);

    // parse the json object from the request
    godmode = jsonParse(result);

    // Dump the json object to see if their are any issues
    jsonDump("godmode", result, 4);

    // Check if the player is a member of staff
    if (godmode["is-staff"]) {
        // Give godmode
        player.ignoreme = 1;
        player enableInvulnerability();
    } else {
        // Dont give godmode
        player.ignoreme = 0;
        player disableInvulnerability();
    }

    // Loop through the result to tell the player a pretty board
    foreach(message in godmode["result"])
        player tell(message);
}
