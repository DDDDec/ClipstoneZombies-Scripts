// Include base game scripts
#include maps/mp/_utility;
#include common_scripts/utility;

// Include custom clipstone zombies scripts
#include scripts/zm/clipstone/utils;

messages()
{
    // Loop for sending messages every x seconds
    for(;;)
    {
        // Wait x amount of seconds to continue looping
        wait 300;

        // Set the headers for the POST request
        headers = [];
        headers["Content-Type"] = "application/json";
        headers["Api_Key"] = level.Clipstone["api_key"];
        headers["Api_Agent"] = level.Clipstone["api_agent"];

        // Set the wanted data for the POST request
        data = [];
        data["map"] = getCurrentMap();

        // Send the POST request and wait until the request is finished for the result
        request = httpPost("http://127.0.0.1:8000/api/vanilla/messages", jsonSerialize(data, 4), headers);
        request waittill("done", result);

        // Parse the json from the POST request
        messages = jsonParse(result);

        // Dump the json request for debugging
        jsonDump("messages", result, 4);

        // Tell the player the result of the POST request
        say(messages["result"]);
    }
}