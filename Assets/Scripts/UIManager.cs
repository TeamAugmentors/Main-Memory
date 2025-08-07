using UnityEngine;
using UnityEngine.UI;

public class UIManager : MonoBehaviour
{
    [SerializeField] OptionsScript optionsScript;
    [SerializeField] CreditsScript creditsScript;
    [SerializeField] ExitScript exitScript;
    
    public void OnOptionsButtonClicked()
    {
        //TODO
    }

    public void OnCreditsButtonClicked()
    {
        //TODO
    }
    
    public void OnExitButtonClicked(bool shouldEnablePopup)
    {
        ToggleAllButtons(!shouldEnablePopup);
        exitScript.ToggleExitPopup(shouldEnablePopup);
    }

    public void ToggleAllButtons(bool shouldEnable)
    {
        optionsScript.transform.GetComponent<Button>().interactable = shouldEnable;
        creditsScript.transform.GetComponent<Button>().interactable = shouldEnable;
        exitScript.transform.GetComponent<Button>().interactable = shouldEnable;
    }
}
