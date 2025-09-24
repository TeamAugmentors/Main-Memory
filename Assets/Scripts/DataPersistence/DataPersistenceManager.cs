using System;
using UnityEngine;

public class DataPersistenceManager : MonoBehaviour
{
    public static DataPersistenceManager Instance { get; private set; }

    private GameData _gameData;
    
    private void Awake()
    {
        if (Instance != null)
        {
            Debug.LogError("More than one DataPersistenceManager in scene.");
        }
        
        Instance = this;
    }

    public void NewGame()
    {
        _gameData = new GameData();
    }

    public void LoadGame()
    {
        if (_gameData == null)
        {
            Debug.Log("No game data found. Initializing defaults");
            NewGame();
        }
        
        //TODO push loaded data to scripts that need it
    }

    public void SaveGame()
    {
        //TODO receive data from other scripts to save it
        
        //TODO save data to file using data handler
    }
}
