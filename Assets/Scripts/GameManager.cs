using UnityEngine;
using UnityEngine.Serialization;

public class GameManager : MonoBehaviour
{
    [SerializeField] private Transform conversationDisplay;
    [SerializeField] private Transform gameTriggerMark;
    
    public bool IsStartButtonEnabled { get; set; }

    public void OnGameTriggerPressed()
    {
        IsStartButtonEnabled = !IsStartButtonEnabled;
        
        gameTriggerMark.gameObject.SetActive(IsStartButtonEnabled);
    }
    
    public void StartGameConversation()
    {
        conversationDisplay.gameObject.SetActive(true);
    }
}
