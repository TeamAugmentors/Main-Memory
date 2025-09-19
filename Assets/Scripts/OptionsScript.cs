using UnityEngine;

public class OptionsScript : MonoBehaviour
{
    [SerializeField] private GameObject optionMenu;
    [Header("Ink JSON")]
    [SerializeField] private TextAsset inkJSON;
    
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
            DialogueManager.GetInstance().StartGameConversation(inkJSON);
        }
        else
        {
            RegularCloseOptionMenu();
        }
    }

    private void RegularCloseOptionMenu()
    {
        ToggleOptionMenu(false);
        uiManager.ToggleAllButtons(true);
    }
}
