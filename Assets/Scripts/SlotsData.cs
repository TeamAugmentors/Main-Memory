using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class SlotsData : MonoBehaviour
{
    [SerializeField] private TextMeshProUGUI serialText;
    [SerializeField] private Button slotButton;
    [SerializeField] private TextMeshProUGUI timeText;

    private bool hasSavedData = false;
    
    public void Populate(string serial, string buttomText, string time)
    {
        serialText.text = serial;
        slotButton.GetComponentInChildren<TextMeshProUGUI>().text = buttomText;
        timeText.text = time;
    }

    public void OnSlotClicked()
    {
        if (hasSavedData)
        {
            
        }
        else
        {
            
        }
    }
}
