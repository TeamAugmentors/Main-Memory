using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class ConversationScript : MonoBehaviour
{
    [SerializeField] TextMeshProUGUI conversationText;
    [SerializeField] TextMeshProUGUI Answer;
    [SerializeField] private Button[] optionButtons;

    private void ToggleAnswerText(bool enable)
    {
        Answer.transform.gameObject.SetActive(enable);
    }

    private void PopulateOptionButtons(string[] optionText)
    {
        int currentIndex = 0;
        
        foreach (var currentOption in optionButtons)
        {
            bool currentOptionEnabled = !(currentIndex >= optionText.Length);
            currentOption.gameObject.SetActive(currentOptionEnabled);

            if (currentOptionEnabled)
            {
                currentOption.GetComponentInChildren<TextMeshProUGUI>().text = optionText[currentIndex];
            }
            
            currentIndex++;
        }
    }
    
    public void Populate(string currentText, string[] optionText)
    {
        ToggleAnswerText(false);
        conversationText.text = currentText;
        PopulateOptionButtons(optionText);
    }
}
