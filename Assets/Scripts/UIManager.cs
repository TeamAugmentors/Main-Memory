using System;
using UnityEngine;
using UnityEngine.UI;

public class UIManager : MonoBehaviour
{
    [SerializeField] OptionsScript optionsScript;
    [SerializeField] CreditsScript creditsScript;
    [SerializeField] ExitScript exitScript;
    
    public void OnOptionsButtonClicked(bool shouldEnablePopup)
    {
        optionsScript.ToggleOptionMenu(true);
        ToggleAllButtons(!shouldEnablePopup);
    }

    public void OnCreditsButtonClicked(bool shouldEnablePopup)
    {
        ToggleAllButtons(!shouldEnablePopup);
    }
    
    public void OnExitButtonClicked(bool shouldEnablePopup)
    {
        exitScript.ToggleExitPopup(true);
        ToggleAllButtons(!shouldEnablePopup);
    }
    
    public void ToggleAllButtons(bool shouldEnable)
    {
        optionsScript.transform.GetComponent<Button>().interactable = shouldEnable;
        creditsScript.transform.GetComponent<Button>().interactable = shouldEnable;
        exitScript.transform.GetComponent<Button>().interactable = shouldEnable;
    }
}
