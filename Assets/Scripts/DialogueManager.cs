using System;
using Ink.Runtime;
using UnityEditor.Hardware;
using UnityEngine;
using UnityEngine.InputSystem.XR;
using UnityEngine.Serialization;

public class DialogueManager : MonoBehaviour
{
    [SerializeField] private ConversationScript conversation;
    [SerializeField] private GameObject gameTriggerMark;
    
    private static DialogueManager instance;
    public bool IsStartButtonEnabled { get; set; }
    
    private Story currentStory;

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

    public void OnOption1Pressed()
    {
        ContinueStory();
        Debug.Log("Option 1");
    }

    public void OnOption2Pressed()
    {
        ContinueStory();
        Debug.Log("Option 2");
    }

    public void OnOption3Pressed()
    {
        ContinueStory();
        Debug.Log("Option 3");
    }

    private void ContinueStory()
    {
        if (currentStory.canContinue)
        {
            string[] options = { "yes", "no" };
            
            conversation.Populate(currentStory.Continue(), options);
        }
        else
        {
            //TODO write what to do after dialogue ends
            Debug.Log("End of conversation");
        }
    }
}
