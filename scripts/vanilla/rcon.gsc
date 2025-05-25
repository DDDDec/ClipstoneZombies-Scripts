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
