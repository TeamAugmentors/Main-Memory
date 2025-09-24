using UnityEngine;
using System;
using System.Collections.Generic;
using System.IO;

public class FileDataHandler
{
    private string dataDirPath = "";
    private string dataFileName = "";

    public FileDataHandler(string dataDirPath, string dataFileName)
    {
        this.dataDirPath = dataDirPath;
        this.dataFileName = dataFileName;
    }

    public GameData Load(string profileId)
    {
        string fullPath = Path.Combine(dataDirPath, profileId, dataFileName);

        GameData data = null;

        if (File.Exists(fullPath))
        {
            try
            {
                string dataToLoad = "";
                using (FileStream stream = new FileStream(fullPath, FileMode.Open))
                {
                    using (StreamReader reader = new StreamReader(stream))
                    {
                        dataToLoad = reader.ReadToEnd();
                    }
                }
                
                //deserialize from json to string
                data = JsonUtility.FromJson<GameData>(dataToLoad);
            }
            catch (Exception e)
            {
                Debug.LogError("Error occured when trying to load data from file: " + fullPath + "\n" + e);
                throw;
            }
        }
        
        return data;
    }

    public void Save(GameData data, string profileId)
    {
        string fullPath = Path.Combine(dataDirPath, profileId, dataFileName);

        try
        {
            Directory.CreateDirectory(Path.GetDirectoryName(fullPath));
            
            string json = JsonUtility.ToJson(data, true);
            
            //write in save file
            using (FileStream stream = new FileStream(fullPath, FileMode.Create))
            {
                using (StreamWriter writer = new StreamWriter(stream))
                {
                    writer.Write(json);
                }
            }
        }
        catch (Exception e)
        {
            Debug.LogError("Error occured when trying to save data to file "+ fullPath + "\n" + e);
            throw;
        }
    }

    public Dictionary<string, GameData> LoadAllProfiles()
    {
        Dictionary<string, GameData> profileDictionary = new Dictionary<string, GameData>();

        IEnumerable<DirectoryInfo> directories = new DirectoryInfo(dataDirPath).EnumerateDirectories();

        foreach (DirectoryInfo dir in directories)
        {
            string profileId = dir.Name;
            
            //check if file exists and valid
            string fullPath = Path.Combine(dataDirPath, profileId, dataFileName);
            
            if (!File.Exists(fullPath))
            {
                Debug.LogWarning("Skipping directory when loading all profiles because it does not contain data: " + profileId);
                continue;
            }
            
            // load profile
            GameData profileData = Load(profileId);

            if (profileData != null)
            {
                profileDictionary.Add(profileId, profileData);
            }
            else
            {
                Debug.LogError("Tried to load but something went wrong for ProfileID: " + profileId);
            }
        }
        
        return profileDictionary;
    }
}
