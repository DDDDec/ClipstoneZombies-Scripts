rules(player)
{
    headers = [];
    headers["Content-Type"] = "application/json";
    headers["Api_Key"] = level.Clipstone["api_key"];
    headers["Api_Agent"] = level.Clipstone["api_agent"];

    data = [];

    request = httpPost("http://127.0.0.1:8000/api/vanilla/rules", jsonSerialize(data, 4), headers);
    request waittill("done", result);

    rules = jsonParse(result);

    jsonDump("rules", result, 4);

    foreach(message in rules["result"])
        player tell(message);
}

help(player, args)
{
    headers = [];
    headers["Content-Type"] = "application/json";
    headers["Api_Key"] = level.Clipstone["api_key"];
    headers["Api_Agent"] = level.Clipstone["api_agent"];

    data = [];
    data["page"] = args[1];

    request = httpPost("http://127.0.0.1:8000/api/vanilla/help", jsonSerialize(data, 4), headers);
    request waittill("done", result);

    help = jsonParse(result);

    jsonDump("help", result, 4);

    foreach(message in help["result"])
        player tell(message);
}