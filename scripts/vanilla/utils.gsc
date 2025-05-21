// Include base game scripts
#include maps/mp/_utility;
#include common_scripts/utility;

getCurrentMap()
{
    // Get the location & gamemode of the map
    location = getDvar( "ui_zm_mapstartlocation" );
    gamemode = getDvar( "ui_gametype" );

    // Check which map is being used on the server & return it
    if( location == "processing" )
        return "Buried";
    else if( location == "rooftop" )
        return "DieRise";
    else if( location == "prison" )
        return "MobOfTheDead";
    else if( location == "nuked" )
        return "Nuketown";
    else if( location == "tomb" )
        return "Origins";
    else if( location == "town" )
        return "Town";
    else if( location == "farm" )
        return "Farm";
    else if( location == "transit" )
        if ( gamemode == "zclassic")
    	    return "Tranzit";
        if ( gamemode == "zstandard")
    	    return "Depot";
    return "NA";
}

kickPlayerWithReason(player, reason)
{
    // Execute the kick command on a specific player
    executeCommand("clientkick_for_reason  " + player GetEntityNumber() + " \"" + reason + "\"");
}
