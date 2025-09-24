using System.Collections.Generic;
using Ink.Runtime;

[System.Serializable]
public class GameData
{
    public bool hasStoryStarted;
    public string dateTime;
    public string ink_file;
    public string last_line;

    //initial values
    public GameData()
    {
        hasStoryStarted = false;
        ink_file = "";
        last_line = "";
        dateTime = "00-00-00/00:00:00";
    }
}
