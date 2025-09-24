using UnityEngine;

public class OptionsScript : MonoBehaviour
{
    [SerializeField] private GameObject optionMenu;
    private UIManager uiManager;
    
    private void Awake()
    {
        uiManager = FindFirstObjectByType<UIManager>();
    }
    
    public void ToggleOptionMenu(bool shouldEnable)
    {
        optionMenu.SetActive(shouldEnable);
    }
    
    public void OnCrossButtonClicked()
    {
        if (uiManager == null || DialogueManager.GetInstance() == null)
        {
            return;
        }

        if (DialogueManager.GetInstance().IsStartButtonEnabled)
        {
            ToggleOptionMenu(false);
            DialogueManager.GetInstance().StartGameConversation();
        }
        else
        {
            RegularCloseOptionMenu();
        }
    }

    public void RegularCloseOptionMenu()
    {
        ToggleOptionMenu(false);
        uiManager.ToggleAllButtons(true);
    }
}
