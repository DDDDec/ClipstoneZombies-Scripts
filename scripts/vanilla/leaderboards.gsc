// Include base game scripts
#include maps/mp/_utility;
#include common_scripts/utility;

// Include custom clipstone zombies scripts
#include scripts/zm/clipstone/utils;

leaderboard()
{
    level waittill("end_game");

    players = getPlayers();
    if (players.size > 0) {
        round = int(level.round_number) - 1;

        players = getPlayers();
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

        headers = [];
        headers["Content-Type"] = "application/json";
        headers["Api_Key"] = level.Clipstone["api_key"];
        headers["Api_Agent"] = level.Clipstone["api_agent"];

        data = [];
        data["map"] = getCurrentMap();
        data["players"] = level.playerNames + "";
        data["players_count"] = players.size;
        data["round"] = round;

        request = httpPost("http://127.0.0.1:8000/api/vanilla/leaderboards", jsonSerialize(data, 4), headers);
        request waittill("done", result);

        leaderboard = jsonParse(result);

        jsonDump("leaderboard", result, 4);

        foreach (player in players)
        {
            player tell(leaderboard["result"]);
        }
    }
}
