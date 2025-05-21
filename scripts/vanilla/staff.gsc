// Include base game scripts
#include maps/mp/_utility;
#include common_scripts/utility;

banPlayer(player, args)
{
    headers = [];
    headers["Content-Type"] = "application/json";
    headers["Api_Key"] = level.Clipstone["api_key"];
    headers["Api_Agent"] = level.Clipstone["api_agent"];

    data = [];
    data["staff_guid"] = player getGUID();
    data["player_name"] = args[1];

    request = httpPost("http://127.0.0.1:8000/api/vanilla/banPlayer", jsonSerialize(data, 4), headers);
    request waittill("done", result);

    banPlayer = jsonParse(result);

    jsonDump("banPlayer", result, 4);

    foreach (message in banPlayer["result"])
        player tell(message);
}

godmode(player)
{
    headers = [];
    headers["Content-Type"] = "application/json";
    headers["Api_Key"] = level.Clipstone["api_key"];
    headers["Api_Agent"] = level.Clipstone["api_agent"];

    data = [];
    data["staff_guid"] = player getGUID();

    request = httpPost("http://127.0.0.1:8000/api/vanilla/godmode", jsonSerialize(data, 4), headers);
    request waittill("done", result);

    godmode = jsonParse(result);

    jsonDump("godmode", result, 4);

    if (godmode["is-staff"]) {
        player.ignoreme = 1;
        player enableInvulnerability();
    } else {
        player.ignoreme = 0;
        player disableInvulnerability();
    }

    player tell(godmode["result"]);
}
