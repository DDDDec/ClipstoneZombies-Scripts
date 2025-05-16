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

init()
{
    level thread onPlayerConnect();
    level thread onPlayerSay();
    level thread leaderboard();
    level thread messages();

    level.perk_purchase_limit = 20;

    level.Clipstone["api_key"] = GetDvar("api_key");
    level.Clipstone["api_agent"] = GetDvar("api_agent");
}

onPlayerConnect()
{
    for(;;)
    {
        level waittill("connected", player);

        player thread account(player);
        player thread statistics(player);

        player setclientdvar( "r_fog", "0" );
        player setclientdvar( "r_dof_enable", "0" );

        player.ignoreme = 1;
        player enableInvulnerability();
    }
}
