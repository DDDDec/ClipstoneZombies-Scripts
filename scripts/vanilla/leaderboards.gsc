#include maps/mp/_utility;
#include common_scripts/utility;

#include scripts/zm/clipstone/utils;

uploadLeaderboard()
{
    headers = [];
    headers["Content-Type"] = "application/json";
    headers["Api_Key"] = level.Clipstone["api_key"];
    headers["Api_Agent"] = level.Clipstone["api_agent"];

    data = [];
    data["guid"] = player getGUID();
    data["name"] = player.name;

    request = httpPost("http://127.0.0.1:8000/api/vanilla/leaderboard", jsonSerialize(data, 4), headers);
    request waittill("done", result);

    leaderboard = jsonParse(result);

    jsonDump("leaderboard", result, 4);
}
