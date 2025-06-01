// Include base game scripts
#include maps/mp/_utility;
#include common_scripts/utility;

init()
{
    // Setup database connection
    config = spawnstruct();
    config.host = GetDvar("mysql_host");
    config.user = GetDvar("mysql_user");
    config.password = GetDvar("mysql_pass");
    config.port = int(GetDvar("mysql_port"));
    config.database = GetDvar("mysql_db");
    mysql::set_config(config);

    // Thread onPlayerConnect
    level thread onPlayerConnect();
}

onPlayerConnect()
{
    // Loop for every player who joins
    for(;;)
    {
        // Waittill the player has connected
        level waittill("connected", player);

        // Build array of items for the query
        params = array(player.guid, player.name);

        // Query the database with an insert query
        query = mysql::prepared_statement("insert into `players` (`guid`, `username`) values (?, ?)", params);

        // Waittill the query is finished to proceed
        query waittill("done", result, affected_rows, error);
    }
}
