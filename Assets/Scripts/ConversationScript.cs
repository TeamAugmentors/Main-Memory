using System;
using System.Collections.Generic;
using Ink.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class ConversationScript : MonoBehaviour
{
    [SerializeField] TextMeshProUGUI conversationText;
    [SerializeField] TextMeshProUGUI Answer;
    [SerializeField] TMP_InputField answerInput;
    [SerializeField] private Button[] optionButtons;

    public int getMaxChoiceCount => optionButtons.Length;
    
    private DialogueManager dialogueManager;

    private void Awake()
    {
        dialogueManager = FindFirstObjectByType<DialogueManager>();
    }

    private void ToggleAnswerText(bool enable)
    {
        Answer.transform.gameObject.SetActive(enable);
    }

    private void PopulateOptionButtons(List<Choice> options)
    {
        int currentIndex = 0;
        
        foreach (var currentOption in optionButtons)
        {
            bool currentOptionEnabled = !(currentIndex >= options.Count);
            currentOption.gameObject.SetActive(currentOptionEnabled);

            if (currentOptionEnabled)
            {
                currentOption.GetComponentInChildren<TextMeshProUGUI>().text = options[currentIndex].text;
            }
            
            currentIndex++;
        }
    }
    
    public void Populate(string currentText, List<Choice> options)
    {
        ToggleAnswerText(false);
        conversationText.text = currentText;
        PopulateOptionButtons(options);
    }

    public void ShowNameInputField()
    {
        Answer.gameObject.SetActive(true);
    }
    
    public void HideNameInputField()
    {
        Answer.gameObject.SetActive(false);
    }
    
    public void OnAnswerEndEdit()
    {
        HideNameInputField();
        dialogueManager.OnAnswerSubmit(answerInput.text);
    }
}
