using System.Collections;
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

    [Header("TypeWriter")] 
    public bool shouldEnableTypeWriterEffect;
    [SerializeField] TypewriterScript typewriterScript;
    
    [Header("TextGlitch")]
    public float flickerMin = 0.05f;
    public float flickerMax = 0.15f;
    public int flickerCount = 6;
    
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
    
    public void Populate(string currentText, List<Choice> options)
    {
        ToggleAnswerText(false);

        if (shouldEnableTypeWriterEffect)
        {
            HideAllOptions();
            typewriterScript.StartEffect(currentText, GetTextSpeed(currentText), () =>
            {
                PopulateOptionButtons(options);
            });
        }
        else
        {
            conversationText.text = currentText;
            PopulateOptionButtons(options);
        }
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
    
    private void HideAllOptions()
    {
        foreach (var button in optionButtons)
        {
            button.gameObject.SetActive(false);
        }
    }

    private float GetTextSpeed(string text)
    {
        if (text.Length > 50)
            return 0.05f;

        return 0.0005f;
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
    
    #region Text Glitch
    
    void ProcessAndGlitch(string input)
    {
        int startIdx = input.IndexOf('@');
        int endIdx = input.LastIndexOf('@');

        if (startIdx == -1 || endIdx == -1 || endIdx <= startIdx)
        {
            conversationText.text = input;
            return;
        }

        string originalSegment = input.Substring(startIdx + 1, endIdx - startIdx - 1);

        // Extract glitch replacement after #Glitch:
        int glitchMarker = input.IndexOf("#Glitch: ");
        string glitchSegment = (glitchMarker != -1) 
            ? input.Substring(glitchMarker + 8).Trim() 
            : originalSegment;

        // 3. Build the display string without the @ markers and without #Glitch
        string displayText = input.Substring(0, startIdx) + originalSegment + input.Substring(endIdx + 1, (glitchMarker != -1 ? glitchMarker - endIdx - 1 : input.Length - endIdx - 1));

        // Set initial text
        conversationText.text = displayText;

        // Start glitch coroutine
        StartCoroutine(GlitchCoroutine(displayText, originalSegment, glitchSegment, startIdx));
    }

    IEnumerator GlitchCoroutine(string baseText, string originalSegment, string glitchSegment, int segmentStartIndex)
    {
        for (int i = 0; i < flickerCount; i++)
        {
            string tempText;

            if (i % 2 == 0)
            {
                // Replace the segment with glitch
                tempText = baseText.Substring(0, segmentStartIndex) + glitchSegment + baseText.Substring(segmentStartIndex + originalSegment.Length);
            }
            else
            {
                // Original segment
                tempText = baseText;
            }

            conversationText.text = tempText;
            yield return new WaitForSeconds(Random.Range(flickerMin, flickerMax));
        }

        // Revert back to original
        conversationText.text = baseText;
    }
    
    #endregion
}
