using UnityEngine;
using UnityEngine.UI;

public class GlitchDisplayController : MonoBehaviour
{
    public RawImage targetRawImage;   // Assign ConversationDisplay RawImage
    private Material runtimeMat;

    void Awake()
    {
        // Duplicate material instance so we don’t overwrite the asset
        runtimeMat = Instantiate(targetRawImage.material);
        targetRawImage.material = runtimeMat;
    }

    public void SetGlitch(bool enabled)
    {
        runtimeMat.SetFloat("_Intensity", enabled ? 0.6f : 0f);
    }
}