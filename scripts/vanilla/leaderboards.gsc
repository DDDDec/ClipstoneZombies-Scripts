// Include base game scripts
#include maps/mp/_utility;
#include common_scripts/utility;

// Include custom clipstone zombies scripts
#include scripts/zm/clipstonezombies/utils;

leaderboard()
{
    // Waittill the game has finished
    level waittill("end_game");

    // Gte all the players in the lobby
    players = getPlayers();

    // Check if their are any players in the lobby before sorting the players
    if (players.size > 0) {
    	// Minus one round to get only the rounds completed
        round = int(level.round_number) - 1;

	    // Sort through the players and assign to variable
	    level.playerNames = "";
	    for ( i = 0; i < players.size; i++ )
	    {
		    players[i] resetname();
		    if( level.playerNames == "" )
		    {
			    level.playerNames = players[i].name + "";
		    }
		    else
		    {
			    level.playerNames = level.playerNames + "," + players[i].name;
		    }
	    }

	    // Set the header data we want to send with the request
        headers = [];
        headers["Content-Type"] = "application/json";
        headers["Api_Key"] = level.Clipstone["api_key"];
        headers["Api_Agent"] = level.Clipstone["api_agent"];

	    // Set the data we want to send with the request
        data = [];
        data["map"] = getCurrentMap();
        data["players"] = level.playerNames + "";
        data["players_count"] = players.size;
        data["round"] = round;

	    // Send the request and waittill completed
        request = httpPost("http://127.0.0.1:8000/api/vanilla/leaderboards", jsonSerialize(data, 4), headers);
        request waittill("done", result);

	    // Parse the json object from the request
        leaderboard = jsonParse(result);

	    // Dump the json object to a file to see if their are any issues
        jsonDump("leaderboard", result, 4);

	    // Loop through the result json object to tell the player a pretty board
        foreach (player in players)
            player tell(leaderboard["result"]);
    }
}

getLeaderboards(player)
{
    // Set the header data we want to send with the request
    headers = [];
    headers["Content-Type"] = "application/json";
    headers["Api_Key"] = level.Clipstone["api_key"];
    headers["Api_Agent"] = level.Clipstone["api_agent"];

    // Set the data we want to send with the request
    data = [];
    data["map"] = getCurrentMap();
    data["language"] = player.pers["language"];

    // Send the request and waittill its completed
    request = httpPost("http://127.0.0.1:8000/api/vanilla/getLeaderboards", jsonSerialize(data, 4), headers);
    request waittill("done", result);

    // Parse the json object from the request
    getLeaderboards = jsonParse(result);

    // Dump the json object to see if their are any issues
    jsonDump("getLeaderboards", result, 4);

    // Loop through the result to tell the player a pretty board
    foreach(message in getLeaderboards["result"])
        player tell(message);
}
