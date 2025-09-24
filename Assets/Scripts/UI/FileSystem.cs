using System.Collections.Generic;
using UnityEngine;

public class FileSystem : MonoBehaviour
{
    [SerializeField] private SlotsData[] slotData;
    
    public void Populate()
    {
        gameObject.SetActive(true);
        ActivateMenu();
    }
    
    public void ActivateMenu()
    {
        Dictionary<string, GameData> profilesData = DataPersistenceManager.Instance.GetAllProfilesGameData();

        if (profilesData == null || profilesData.Count == 0)
        {
            return;
        }
        
        int index = 1;
        
        foreach (SlotsData saveSlot in slotData)
        {
            GameData profileData = null;
            profilesData.TryGetValue(saveSlot.GetSlotId, out profileData);
            saveSlot.Populate(profileData, index.ToString());
            index++;
        }
    }
}
