using UnityEngine;
using UnityEngine.Serialization;

public class GameManager : MonoBehaviour
{
    [SerializeField] private Transform gameTriggerMark;
    [SerializeField] private ConversationScript conversation;
    
    public bool IsStartButtonEnabled { get; set; }

    public void OnGameTriggerPressed()
    {
        IsStartButtonEnabled = !IsStartButtonEnabled;
        
        gameTriggerMark.gameObject.SetActive(IsStartButtonEnabled);
    }
    
    public void StartGameConversation()
    {
        conversation.transform.gameObject.SetActive(true);
        conversation.Populate();
    }

    public void OnOption1Pressed()
    {
        //TODO fill up with actual text
        Debug.Log("Option 1");
    }

    public void OnOption2Pressed()
    {
        //TODO fill up with actual text
        Debug.Log("Option 2");
    }

    public void OnOption3Pressed()
    {
        //TODO fill up with actual text
        Debug.Log("Option 3");
    }
}
