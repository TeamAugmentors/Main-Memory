using System;
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
    [SerializeField] float flickerMin = 1f;
    [SerializeField] float flickerMax = 1f;
    
    private int glitchStartIndex;
    private string originalSegment;
    private string glitchSegment;
    private string displayText;
    private bool HasGlitchText => glitchSegment is { Length: > 0 };
    private bool hasNextBtnPressed { get; set; }
    
    public int getMaxChoiceCount => optionButtons.Length;
    
    private DialogueManager dialogueManager;
    private GlitchDisplayController glitchController;

    private string glitchMaterialTag = "<color=#FF0000>";
    private string closingMaterialTag = "</color>";
    
    private void Awake()
    {
        dialogueManager = FindFirstObjectByType<DialogueManager>();
        glitchController = GetComponent<GlitchDisplayController>();
    }
    
    private void ToggleAnswerText(bool enable)
    {
        Answer.transform.gameObject.SetActive(enable);
    }
    
    public void Populate(string currentText, List<Choice> options, string glitchText, bool IsGameLoading = false)
    {
        hasNextBtnPressed = true;
        ToggleAnswerText(false);
        glitchController.SetGlitch(false);

        if (glitchText.Length > 0)
        {
            //process text before showing
            currentText = ProcessAndGlitch(currentText, glitchText);
        }
        
        if (shouldEnableTypeWriterEffect && !IsGameLoading)
        {
            HideAllOptions();
            typewriterScript.StartEffect(currentText, GetTextSpeed(currentText), () =>
            {
                PostDisplayText(options);
            });
        }
        else
        {
            conversationText.text = currentText;
            PostDisplayText(options);
        }
    }

    private void PostDisplayText(List<Choice> options)
    {
        PopulateOptionButtons(options);
        if (HasGlitchText)
        {
            StartCoroutine(GlitchCoroutine(displayText, originalSegment, glitchSegment, glitchStartIndex));
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

    public void StopTypewriter()
    {
        typewriterScript.StopAllCoroutines();
        typewriterScript.RevealInstantly();
    }
    
    #region Text Glitch
    
    private string ProcessAndGlitch(string input, string glitchText)
    {
        int startIdx = input.IndexOf('@');
        int endIdx = input.LastIndexOf('@');

        if (startIdx == -1 || endIdx == -1 || endIdx <= startIdx)
        {
            return input;
        }

        string originalSegment = input.Substring(startIdx + 1, endIdx - startIdx - 1);
        
        // 3. Build the display string without the @ markers
        string displayText = input.Substring(0, startIdx) + originalSegment + input.Substring(endIdx + 1, input.Length - endIdx - 1);

        //store glitch variables
        this.displayText = displayText;
        this.originalSegment = originalSegment;
        glitchSegment = glitchText;
        glitchStartIndex = startIdx;
        hasNextBtnPressed = false;
        
        // Set initial text
        return displayText;
    }

    IEnumerator GlitchCoroutine(string baseText, string originalSegment, string glitchSegment, int segmentStartIndex)
    {
        //wait before glitch
        if (hasNextBtnPressed)
        {
            yield return null;
        }
        
        yield return new WaitForSeconds(flickerMin);
        
        if (!hasNextBtnPressed)
        {
            glitchController.SetGlitch(true);
            AudioManager.Instance.PlaySFX("GlitchSFX");
            conversationText.text = baseText.Replace(originalSegment, glitchMaterialTag + glitchSegment + closingMaterialTag);
        }
        else
        {
            yield break;
        }
        
        yield return new WaitForSeconds(flickerMax);
        
        if (!hasNextBtnPressed)
        {
            glitchController.SetGlitch(false);
            
            conversationText.text = baseText.Replace(glitchSegment, glitchMaterialTag + originalSegment + closingMaterialTag);
        }
    }
    
    #endregion
}
