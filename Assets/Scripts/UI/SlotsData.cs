using System.Net.Mime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class SlotsData : MonoBehaviour
{
    [SerializeField] string slotId;
    [SerializeField] private TextMeshProUGUI serialText;
    [SerializeField] private TMP_InputField slotButton;
    [SerializeField] private TextMeshProUGUI timeText;
    [SerializeField] private Button[] dataActionBtns;
    
    public string GetSlotId => slotId;
    private Files files;
    private void Start()
    {
        files = FindFirstObjectByType<Files>();
    }
    
    public void Populate(GameData data, string serial)
    {
        serialText.text = serial;
        
        if (data == null)
        {
            timeText.text = "00/00/0000 : 00:00";
            dataActionBtns[1].interactable = false;
        }
        else
        {
            slotButton.GetComponent<Image>().color = Color.darkGreen;
            timeText.text = data.dateTime;
        }
    }

    public void OnSaveButtonClicked(string id)
    {
        DataPersistenceManager.Instance.SaveGame(id);
        files.OnCloseFile();
    }

    public void OnLoadButtonClicked(string id)
    {
        DataPersistenceManager.Instance.LoadGame(id);
        files.OnCloseFile();
    }
}
