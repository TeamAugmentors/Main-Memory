using System.Collections.Generic;
using Ink.Runtime;
using UnityEngine;

public class DialogueManager : MonoBehaviour
{
    [SerializeField] private ConversationScript conversation;
    [SerializeField] private GameObject gameTriggerMark;
    [SerializeField] private OptionsScript optionsScript;
    [SerializeField] private GameObject GameVisualChanges;
    
    private static DialogueManager instance;
    public bool IsStartButtonEnabled { get; set; }
    
    private Story currentStory;
    private List<Choice> options;
    
    public static DialogueManager GetInstance()
    {
        return instance;
    }
    
    private void Awake()
    {
        if (instance != null)
        {
            Debug.LogWarning("More than one instance of DialogueManager found!");
        }
        
        instance = this;
    }

    private void Start()
    {
        IsStartButtonEnabled = false;
        conversation.gameObject.SetActive(false);
        GameVisualChanges.SetActive(false);
    }
    
    public void OnGameTriggerPressed()
    {
        IsStartButtonEnabled = !IsStartButtonEnabled;
        gameTriggerMark.SetActive(IsStartButtonEnabled);
    }
    
    public void StartGameConversation(TextAsset inkJSON)
    {
        currentStory = new Story(inkJSON.text);
        conversation.transform.gameObject.SetActive(true);
        ContinueStory();
    }
    
    private void ContinueStory()
    {
        if (currentStory.canContinue)
        {
            var currentText = currentStory.Continue();
            options = GetCurrentChoices();
            
            if (options == null || options.Count == 0)
            {
                Debug.Log("No options found!");
            }
            
            conversation.Populate(currentText, options);
        }
        else
        {
            //TODO write what to do after dialogue ends
            Debug.Log("End of conversation");
        }
    }

    private List<Choice> GetCurrentChoices()
    {
        List<Choice> currentChoices = currentStory.currentChoices;

        if (currentChoices.Count > conversation.getMaxChoiceCount)
        {
            Debug.LogError("Max choice count is " + conversation.getMaxChoiceCount + " but given " + currentChoices.Count + " choices");
            return null;
        }

        return currentChoices;
    }

    public void MakeChoice(int choiceIndex)
    {
        currentStory.ChooseChoiceIndex(choiceIndex);

        ContinueStory();
        
        if ((bool)currentStory.variablesState[InkVariables.PREMATURE_EXIT])
        {
            conversation.gameObject.SetActive(false);
            optionsScript.ToggleOptionMenu(true);
            return;
        }
        
        if ((bool)currentStory.variablesState[InkVariables.WAITING_FOR_NAME])
        {
            conversation.ShowNameInputField();
        }
        
        if ((bool)currentStory.variablesState[InkVariables.SAVED_SETTINGS])
        {
            GameVisualChanges.SetActive(true);
        }
        
        if ((bool)currentStory.variablesState[InkVariables.HAS_GAME_COMPLETED])
        {
            //Reached game end. roll game credits
            Debug.Log("Game completed");
        }
    }
    
    public void OnAnswerSubmit(string name)
    {
        currentStory.variablesState[InkVariables.PLAYER_NAME] = name;
        currentStory.variablesState[InkVariables.WAITING_FOR_NAME] = false;
        
        ContinueStory();
    }
}
