using UnityEngine;

public class FileSystem : MonoBehaviour
{
    [SerializeField] private SlotsData[] slotData;
    private int currentSelectedSlot;
    
    public void Populate()
    {
        currentSelectedSlot = -1;
        gameObject.SetActive(true);

        int index = 1;
        
        foreach (SlotsData data in slotData)
        {
            data.Populate(index.ToString(), "EMPTY SLOT", "00:00 : 0/0/0000");
            index++;
        }
    }

    public void OnSelect(int index)
    {
        currentSelectedSlot = index;
    }
}
