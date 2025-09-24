using System.Collections.Generic;
using System.Linq;
using UnityEngine;

public class DataPersistenceManager : MonoBehaviour
{
    [Header("File Storage Config")] 
    [SerializeField] private string fileName;
    
    public static DataPersistenceManager Instance { get; private set; }

    private GameData _gameData;
    private List<IDataPersistence> dataPersistenceObjects;
    private FileDataHandler dataHandler;
    public string selectedProfileId = "";
    
    private void Awake()
    {
        if (Instance != null)
        {
            Debug.LogError("More than one DataPersistenceManager in scene.");
            Destroy(gameObject);
            return;
        }
        
        Instance = this;
        DontDestroyOnLoad(gameObject);
        
        dataHandler = new FileDataHandler(Application.persistentDataPath, fileName);
    }

    private void Start()
    {
        dataHandler = new FileDataHandler(Application.persistentDataPath, fileName);
        dataPersistenceObjects = FindAllDataPersistenceObjects();
    }
    
    public void NewGame()
    {
        _gameData = new GameData();
    }

    public void LoadGame(string id)
    {
        selectedProfileId = id;
        _gameData = dataHandler.Load(selectedProfileId);
        
        if (_gameData == null)
        {
            Debug.Log("No game data found. Initializing defaults");
            NewGame();
        }

        foreach (var data in dataPersistenceObjects)
        {
            data.LoadData(_gameData);
        }
    }

    public void SaveGame(string id)
    {
        selectedProfileId = id;
        
        foreach (var data in dataPersistenceObjects)
        {
            data.SaveData(ref _gameData);
        }

        _gameData.dateTime = System.DateTime.Now.ToString();
        dataHandler.Save(_gameData, selectedProfileId);
    }

    private List<IDataPersistence> FindAllDataPersistenceObjects()
    {
        return FindObjectsByType<MonoBehaviour>(FindObjectsSortMode.None).OfType<IDataPersistence>().ToList();
    }

    public Dictionary<string, GameData> GetAllProfilesGameData()
    {
        return dataHandler.LoadAllProfiles();
    }
}
