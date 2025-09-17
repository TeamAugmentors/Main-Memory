using UnityEngine;

public class OptionsScript : MonoBehaviour
{
    [SerializeField] private GameObject optionMenu;

    private UIManager uiManager;
    private GameManager gameManager;
    
    private void Awake()
    {
        uiManager = FindFirstObjectByType<UIManager>();
        gameManager = FindFirstObjectByType<GameManager>();
    }
    
    public void ToggleOptionMenu(bool shouldEnable)
    {
        optionMenu.SetActive(shouldEnable);
    }
    
    public void OnCrossButtonClicked()
    {
        if (uiManager == null || gameManager == null)
        {
            return;
        }

        if (gameManager.IsStartButtonEnabled)
        {
            ToggleOptionMenu(false);
            gameManager.StartGameConversation();
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
