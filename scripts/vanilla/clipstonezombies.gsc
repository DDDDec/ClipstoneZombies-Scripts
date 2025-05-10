#include maps/mp/_utility;
#include common_scripts/utility;

#include scripts/zm/clipstone/utils;
#include scripts/zm/clipstone/account;
#include scripts/zm/clipstone/autoMessages;
#include scripts/zm/clipstone/leaderboards;
#include scripts/zm/clipstone/stats;

init()
{
    level thread onPlayerConnect();
    level thread uploadLeaderboard();

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
        player thread autoMessages(player);
        player thread uploadStats(player);

        player setclientdvar( "r_fog", "0" );
        player setclientdvar( "r_dof_enable", "0" );

        player.ignoreme = 1;
        player enableInvulnerability();
    }
}
