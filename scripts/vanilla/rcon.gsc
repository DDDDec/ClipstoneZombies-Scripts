// Include base game scripts
#include maps/mp/_utility;
#include common_scripts/utility;

// Include custom clipstone zombies scripts
#include scripts/zm/clipstonezombies/utils;

kickAllPlayers() 
{
    players = getPlayers();

    foreach(player in players)
        kickPlayerWithReason(player, "                                                                                                                                                                                                                   [^1Clipstone^7] You got ^1KICKED^7                                                                                                                                                                      Check at ^1https://zombies.clipst.one^7");
}

kickPlayer(args)
{
    players = getPlayers();

    foreach(player in players)
        if (player.guid == args[1])
            kickPlayerWithReason(player, "                                                                                                                                                                                                                   [^1Clipstone^7] You got ^1KICKED^7                                                                                                                                                                      Check at ^1https://zombies.clipst.one^7");
}

GiveAllMoney(args)
{
    players = getPlayers();

    foreach(player in players)
        player.score += int(args[1]);
}

GivePlayerMoney(args)
{
    players = getPlayers();

    foreach(player in players) {
        if (player.guid == args[1]) {
            player.score += int(args[2]);
        }
    }
}
