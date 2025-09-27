using System.Collections.Generic;
using Ink.Runtime;
using UnityEngine;

public class DialogueManager : MonoBehaviour, IDataPersistence
{
    [SerializeField] private ConversationScript conversation;
    [SerializeField] private GameObject gameTriggerMark;
    [SerializeField] private OptionsScript optionsScript;
    [SerializeField] private GameObject GameVisualChanges;
    
    [Header("Ink JSON")]
    [SerializeField] private TextAsset inkJSON;
    
    private static DialogueManager instance;
    public bool IsStartButtonEnabled { get; set; }
    
    private Story currentStory;
    private List<Choice> options;
    private bool hasStoryStarted;
    
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
        DataPersistenceManager.Instance.NewGame();
        IsStartButtonEnabled = false;
        hasStoryStarted = false;
        conversation.gameObject.SetActive(false);
        GameVisualChanges.SetActive(false);
        PopulateCurrentStory();
    }

    private void PopulateCurrentStory()
    {
        currentStory = new Story(inkJSON.text);
    }
    
    public void OnGameTriggerPressed()
    {
        IsStartButtonEnabled = !IsStartButtonEnabled;
        gameTriggerMark.SetActive(IsStartButtonEnabled);
    }

    public void ResetTriggerPressed()
    {
        IsStartButtonEnabled = false;
        gameTriggerMark.SetActive(false);
    }
    
    public void StartGameConversation()
    {
        PopulateCurrentStory();
        conversation.transform.gameObject.SetActive(true);
        ContinueStory();
    }

    private void ResetToMainMenu()
    {
        ResetTriggerPressed();
        GameVisualChanges.SetActive(false);
        conversation.gameObject.SetActive(false);
        optionsScript.RegularCloseOptionMenu();
    }
    
    public void LoadGameConversation(GameData data)
    {
        RefreshGameState();
        
        if (!data.hasStoryStarted)
        {
            ResetToMainMenu();
            return;
        }
        
        GameVisualChanges.SetActive((bool)currentStory.variablesState[InkVariables.SAVED_SETTINGS]);
        
        optionsScript.ToggleOptionMenu(false);
        conversation.transform.gameObject.SetActive(true);
        currentText = data.last_line;

        if (currentStory.currentChoices.Count > 0)
        {
            options = GetCurrentChoices();
            
            if (options == null || options.Count == 0)
            {
                Debug.Log("No options found!");
            }
            
            var glitchText = HandleTags(currentStory.currentTags);
            
            conversation.Populate(currentText, options, glitchText, true);
        }
        else if((bool)currentStory.variablesState[InkVariables.WAITING_FOR_NAME])
        {
            var glitchText = HandleTags(currentStory.currentTags);
            options = new List<Choice>();
            conversation.Populate(currentText, options, glitchText, true);
            conversation.ShowNameInputField();
        }
    }
    
    #region Story

    private string currentText;

    private void RefreshGameState()
    {
        AudioManager.Instance.StopSFX();
        conversation.StopAllCoroutines();
        conversation.StopTypewriter();
    }
    
    private void ContinueStory()
    {
        RefreshGameState();
        
        if (currentStory.canContinue)
        {
            hasStoryStarted = true;
            currentText = currentStory.Continue();
            options = GetCurrentChoices();
            
            if (options == null || options.Count == 0)
            {
                Debug.Log("No options found!");
            }
            
            var glitchText = HandleTags(currentStory.currentTags);
            
            conversation.Populate(currentText, options, glitchText);
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

    private string HandleTags(List<string> currentTags)
    {
        string glitchText = string.Empty;
        
        foreach (string tag in currentTags)
        {
            string[] tags = tag.Split(':');

            if (tags.Length != 2)
            {
                Debug.LogError("Tags could not be properly parsed: " + tags);
                continue;
            }
            
            string tagKey = tags[0];
            string tagValue = tags[1];

            switch (tagKey)
            {
                case InkVariables.GLITCH_TAG:
                    glitchText = tagValue;
                    break;
                default:
                    Debug.LogError(tagKey + " is not a valid tag: " + tagValue);
                    break;
            }
        }
        
        return glitchText;
    }
    
    #endregion
    
    public void OnAnswerSubmit(string name)
    {
        currentStory.variablesState[InkVariables.PLAYER_NAME] = name;
        currentStory.variablesState[InkVariables.WAITING_FOR_NAME] = false;
        
        ContinueStory();
    }

    #region SaveSystem
    
    public void LoadData(GameData data)
    {
        currentStory.state.LoadJson(data.ink_file);
        
        if (currentStory != null)
        {
            OnGameTriggerPressed();
            LoadGameConversation(data);
        }
    }
    
    public void SaveData(ref GameData data)
    {
        //save ink file progress
        if (currentStory != null)
        {
            data.hasStoryStarted = hasStoryStarted;
            data.ink_file = currentStory.state.ToJson();
            data.last_line = currentText;
        }
        else
        {
            Debug.Log("Nothing to save");
        }
    }
    
    #endregion
}
