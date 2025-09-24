using UnityEngine;
using UnityEngine.UI;

public class Files : MonoBehaviour
{
    [SerializeField] private FileSystem fileSystem;
    [SerializeField] private Button fileButton;
    private void Awake()
    {
        OnCloseFile();
    }

    public void OnClick()
    {
        if (fileSystem.gameObject.activeSelf)
        {
            return;
        }

        fileSystem.Populate();
        fileButton.interactable = false;
    }
    
    private void ToggleFileSystem(bool enable)
    {
        fileSystem.gameObject.SetActive(enable);
    }
    
    public void OnCloseFile()
    {
        ToggleFileSystem(false);
        fileButton.interactable = true;
    }
}
