using UnityEngine;

[System.Serializable]
public class GameData
{
    public string player_name;
    public bool has_alias;
    public bool saved_settings;
    public bool has_game_completed;

    //initial values
    public GameData()
    {
        player_name = "";
        has_alias = false;
        saved_settings = false;
        has_game_completed = false;
    }
}
