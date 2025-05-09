#include maps/mp/_utility;
#include common_scripts/utility;

#include scripts/zm/clipstone/utils;

autoMessages(player)
{
    for(;;)
    {
        headers = [];
        headers["Content-Type"] = "application/json";
        headers["Api_Key"] = level.Clipstone["api_key"];
        headers["Api_Agent"] = level.Clipstone["api_agent"];

        data = [];

        request = httpPost("http://127.0.0.1:8000/api/vanilla/autoMessages", jsonSerialize(data, 4), headers);
        request waittill("done", result);

        autoMessages = jsonParse(result);

        jsonDump("autoMessages", result, 4);

        player tell(autoMessages["autoMessage"]);

        wait 5;
    }
}