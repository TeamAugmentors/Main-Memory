using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class SlotsData : MonoBehaviour
{
    [SerializeField] private TextMeshProUGUI serialText;
    [SerializeField] private TMP_InputField slotButton;
    [SerializeField] private TextMeshProUGUI timeText;

    private int slotIndex;
    
    public void Populate(string serial, string time, int slotIndex)
    {
        serialText.text = serial;
        timeText.text = time;
        this.slotIndex = slotIndex;
    }

    public void OnSavelicked()
    {
        
    }

    public void OnLoadClicked()
    {
        
    }
}
