// Include base game scripts
#include maps/mp/_utility;
#include common_scripts/utility;

// Include custom clipstone zombies scripts
#include scripts/zm/clipstone/utils;

statistics(player)
{
    player endon("disconnect");
    level waittill("end_game");

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

    // Send the POST request and wait until the request is finished for the result
    request = httpPost("http://127.0.0.1:8000/api/vanilla/statistics", jsonSerialize(data, 4), headers);
    request waittill("done", result);

    // Parse the json from the POST request
    statistics = jsonParse(result);

    // Dump the json request for debugging
    jsonDump("statistics", result, 4);

    // Tell the player the result of the POST request
    player tell(statistics["result"]);
}