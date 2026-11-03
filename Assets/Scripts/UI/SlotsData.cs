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
        
        bool hasSave = data != null;

        dataActionBtns[1].interactable = hasSave;

        slotButton.GetComponent<Image>().color =
            hasSave ? Color.darkGreen : Color.white;

        timeText.text = hasSave ? data.dateTime : "00/00/0000 : 00:00";
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
