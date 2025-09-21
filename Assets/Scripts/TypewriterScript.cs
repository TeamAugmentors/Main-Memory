using System;
using System.Collections;
using TMPro;
using UnityEngine;

public class TypewriterScript : MonoBehaviour
{
    public TextMeshProUGUI textUI;
    public float typeSpeed;
    
    public void StartEffect(string inputText, float speed, Action onComplete)
    {
        typeSpeed = speed;
        textUI.text = inputText;
        textUI.maxVisibleCharacters = 0;
        StartCoroutine(RevealText(() =>
        {
            onComplete?.Invoke();
        }));
    }

    IEnumerator RevealText(Action onComplete)
    {
        int total = textUI.text.Length;

        for (int i = 0; i <= total; i++)
        {
            textUI.maxVisibleCharacters = i;
            yield return new WaitForSeconds(typeSpeed);
        }
        
        onComplete?.Invoke();
    }
}
