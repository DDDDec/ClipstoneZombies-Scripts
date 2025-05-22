rules(player)
{
    // Set the headers to send with the request
    headers = [];
    headers["Content-Type"] = "application/json";
    headers["Api_Key"] = level.Clipstone["api_key"];
    headers["Api_Agent"] = level.Clipstone["api_agent"];

    // Set the data we want to send with the request
    data = [];
    data["guid"] = player getGUID();
    data["language"] = player.pers["language"];

    // Send the request & waittill its complete
    request = httpPost("http://127.0.0.1:8000/api/vanilla/rules", jsonSerialize(data, 4), headers);
    request waittill("done", result);

    // Parse the json object from the request
    rules = jsonParse(result);

    // Dump the json object to see if their are any issues
    jsonDump("rules", result, 4);

    // Loop through the result to tell the player a pretty board
    foreach(message in rules["result"])
        player tell(message);
}

help(player, args)
{
    // Set the headers to send with the request
    headers = [];
    headers["Content-Type"] = "application/json";
    headers["Api_Key"] = level.Clipstone["api_key"];
    headers["Api_Agent"] = level.Clipstone["api_agent"];

    // Set the data we want to send with the request
    data = [];
    data["guid"] = player getGUID();
    data["page"] = args[1];
    data["language"] = player.pers["language"];

    // Send the request & waittill its complete
    request = httpPost("http://127.0.0.1:8000/api/vanilla/help", jsonSerialize(data, 4), headers);
    request waittill("done", result);

    // Parse the json object from the request
    help = jsonParse(result);

    // Dump the json object to see if their are any issues
    jsonDump("help", result, 4);

    // Loop through the result to tell the player a pretty board
    foreach(message in help["result"])
        player tell(message);
}
