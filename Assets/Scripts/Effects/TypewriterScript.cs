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
        float prevCharDelay = 0f;
        
        for (int i = 0; i < total; i++)
        {
            textUI.maxVisibleCharacters = i;

            float tempDelay = textUI.text[i] == ',' ? InkVariables.COMMA_DELAY : 
                IsPunctuation(textUI.text[i]) ? InkVariables.DOT_DELAY : 0f;

            tempDelay *= i == total - 1 ? 0 : 1;
            
            yield return new WaitForSeconds(typeSpeed + prevCharDelay);
            
            prevCharDelay = tempDelay;
        }
        
        onComplete?.Invoke();
    }

    public void RevealInstantly()
    {
        textUI.maxVisibleCharacters = Int32.MaxValue;
    }
    
    private bool IsPunctuation(char character)
    {
        if(character == '.' || character == '!' || character == '?')
            return true;
        
        return false;
    }
}
