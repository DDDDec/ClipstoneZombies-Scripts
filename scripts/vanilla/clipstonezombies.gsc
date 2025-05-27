// Include base game scripts
#include maps/mp/_utility;
#include common_scripts/utility;

// Include custom clipstone zombies scripts
#include scripts/zm/clipstonezombies/utils;
#include scripts/zm/clipstonezombies/commands;
#include scripts/zm/clipstonezombies/account;
#include scripts/zm/clipstonezombies/messages;
#include scripts/zm/clipstonezombies/leaderboards;
#include scripts/zm/clipstonezombies/statistics;
#include scripts/zm/clipstonezombies/information;
#include scripts/zm/clipstonezombies/staff;
#include scripts/zm/clipstonezombies/rcon;

init()
{
    // Initialize level threads & loops
    level thread onPlayerConnect();
    level thread onPlayerSay();
    level thread leaderboard();
    level thread messages();

    // Set the initial starting perks to over the max limit
    level.perk_purchase_limit = 20;

    // Set the api key and agent for sending and recieving requests
    level.Clipstone["api_key"] = GetDvar("api_key");
    level.Clipstone["api_agent"] = GetDvar("api_agent");

    // Add RCON Commands
    addCommand("kickAllPlayers", ::kickAllPlayers);
    addCommand("kickPlayer", ::kickPlayer);

    addCommand("giveAllMoney", ::giveAllMoney);
    addCommand("givePlayerMoney", ::givePlayerMoney);
}

onPlayerConnect()
{
    for(;;)
    {
        // Waittill the player has connected
        level waittill("connected", player);

        // Initialize player threas & loops
        player thread account(player);
        player thread statistics(player);

        // Set the client dvars for the game
        player setclientdvar( "r_fog", "0" );
        player setclientdvar( "r_dof_enable", "0" );
    }
}
