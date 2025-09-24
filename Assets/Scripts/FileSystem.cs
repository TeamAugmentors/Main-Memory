using UnityEngine;

public class FileSystem : MonoBehaviour
{
    [SerializeField] private SlotsData[] slotData;
    
    public void Populate()
    {
        gameObject.SetActive(true);

        int index = 1;
        
        foreach (SlotsData data in slotData)
        {
            data.Populate(index.ToString(), "00:00 : 0/0/0000", index);
            index++;
        }
    }
}
