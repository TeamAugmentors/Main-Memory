using System;
using UnityEngine;

public class ExitScript : MonoBehaviour
{
    [SerializeField] private GameObject exitPopup;

    private UIManager uiManager;
    
    private void Awake()
    {
        uiManager = FindFirstObjectByType<UIManager>();
    }

    public void ToggleExitPopup(bool shouldEnable)
    {
        exitPopup.SetActive(shouldEnable);
    }

    public void OnYesButtonClicked()
    {
        //TODO
    }

    public void OnNoButtonClicked()
    {
        if (uiManager != null)
        {
            ToggleExitPopup(false);
            uiManager.ToggleAllButtons(true);
        }
    }
}
